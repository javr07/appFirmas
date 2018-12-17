class DocumentsController < ApplicationController
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
    	#@users = User.all.where.not(id: current_user)
    	#@document = Document.new
    	@documents = Document.where(id: Collaborator.select('document_id').where(user_id: current_user.id))
  	end
	def edit
		@document = Document.find(params[:id])
	end
	def create
		@document = Document.new(document_params)
		@document.user_id = current_user.id
		if @document.save
		#	current_user.documents << @document
			redirect_to documents_path
		else 
			render 'new'	
		end
	end

	def document_user_upload
    	@document = Document.find params[:documentid]
    	@document.users = params[:users]
    	@document.save
    	redirect_to documents_path
	  end
	  
	def update
		@document = Document.find(params[:id])
		if @document.update(document_reduce_params)
			redirect_to @document
		end
	end

	private
	def document_reduce_params
		params.require(:document).permit(:nombre, :descripcion)
	end
	def document_params
		params.require(:document).permit(:nombre, :file, :descripcion)
	end
end
