class DocumentsController < ApplicationController
	require 'openssl'
	require 'tempfile'
	require 'origami'

	def index
		@documents = Document.where(user_id: current_user.id)
	end
	def show
		@document = Document.find(params[:id])
	end
	def new
		@document = Document.new
	end
	def allshared
    	@documents = Document.where(id: Collaborator.select('document_id').where(user_id: current_user.id))
  	end
	def edit
		@document = Document.find(params[:id])
	end
	def create
		@document = Document.new(document_params)
		@document.user_id = current_user.id
		if @document.save
			flash[:notice] = "¡Documento creado!"
			redirect_to documents_path
		else 
			render 'new'	
		end
	end

	def update
		@document = Document.find(params[:id])
		if @document.update(document_reduce_params)
			flash[:notice] = "¡Documento actualizado!"
			redirect_to @document
		end
	end

	def document_user_upload
    	@document = Document.find params[:documentid]
    	@document.users = params[:users]
		@document.save
		flash[:notice] = "¡Documento compartido!"
    	redirect_to documents_path
	  end

	def sign
		@document = Document.find(params[:id])
	end

	def verifySignature

		@document = Document.find(params[:documentid])
		@newDocument = Document.new(document_sign_params)
		@newDocument.nombre = @document.nombre + '_firmadoPor_' + current_user.nombre
		@newDocument.descripcion = @document.descripcion
		
		archivo = File.read(@newDocument.privateKey.tempfile.path)
		#Creación de la llave con base en la llave privada
		begin
			puts "PASO"
			key = OpenSSL::PKey::RSA.new archivo, @newDocument.password
		rescue Exception => e
			puts "NO PASO"
			redirect_to documents_sign_path(id: @document.id), alert: "Contraseña incorrecta"
		end

		digest = OpenSSL::Digest::SHA256.new

		path = Tempfile.new(['uploaded', 'pdf'], Rails.root.to_s + '/tmp/')
		File.open(path, 'wb') do |file|
			file.write(@document.file.download)
		end

		document = File.open(path)

		newSignature = key.sign digest, document.path

		tmpPath = Tempfile.new(['public_digest', '.pdf'], Rails.root.to_s + '/tmp/')
		Prawn::Document.generate(tmpPath) do
			font "Times-Roman"
			text "public key: + #{key.public_key.to_s}", :align => :center
			text "digest: + #{digest.to_s}", :align => :center
		end

		#COMBINAR PDF DE FIRMA CON EL ORIGINAL
		pdf = CombinePDF.new
		pdf << CombinePDF.load(document.path)
		pdf << CombinePDF.load(tmpPath.path)
		finalDoc = Tempfile.new(['signed', '.pdf'], Rails.root.to_s + '/tmp/')
		pdf.save(finalDoc.path)

		certificate = generate_certificate(key)
		pdf_certified = Origami::PDF.read finalDoc.path
		pdf_page = pdf_certified.get_page(1)
		rectangle = Origami::Annotation::Widget::Signature.new
		rectangle.Rect = Origami::Rectangle[:llx => 89.0, :lly => 386.0,:urx =>190.0, :ury => 353.0]

		#AÑADIR LA FIRMA AL RECTANGULO CREADO
		pdf_page.add_annotation(rectangle)
		pdf_certified.sign(certificate, key, 
				:method => 'adbe.pkcs7.sha1',
				:annotation => rectangle,
				:location => 'México',
				:contact => current_user.email,
				:reason => "firma",
				:issuer => current_user.nombre)

		final_certified = Tempfile.new(['certified', '.pdf'], Rails.root.to_s + '/tmp/')
		pdf_certified.save(final_certified.path)

		@newDocument.file.attach(io: File.open(final_certified.path),
								filename: 'signed' + @newDocument.id.to_s + '.pdf',
								content_type: 'application/pdf')
		

		@newDocument.user_id = current_user.id
		puts "GUARDANDO COLABORADOR"
		users = [@document.user_id]
		@newDocument.users = users
		@newDocument.signed = true
		@newDocument.save

		flash[:notice] = "¡Documento firmado!"
		redirect_to @newDocument 
	end

	def generate_certificate(key)
		user = User.find(current_user.id)
		name = OpenSSL::X509::Name.new [['CN', "#{user.nombre}"], ['DC', 'UV']]
		certificate = OpenSSL::X509::Certificate.new
		certificate.version = 2
		certificate.serial = 0
		certificate.not_before = Time.now
		certificate.not_after = Time.now + 3600
		certificate.public_key = key.public_key
		certificate.subject = name
		certificate.issuer = name
		certificate
	end

	private
	def document_reduce_params
		params.require(:document).permit(:nombre, :descripcion)
	end
	def document_params
		params.require(:document).permit(:nombre, :file, :descripcion, :id)
	end
	def document_sign_params
		params.require(:document).permit(:privateKey, :password, :documentid)
	end
end
