class SignaturesController < ApplicationController
    require 'openssl'
    
    def new
        @signature = Signature.new
    end

    def create
        @signature = Signature.new(signature_params)
        key = OpenSSL::PKey::RSA.new 2048
        cipher = OpenSSL::Cipher.new 'AES-128-CBC' 
        public = Tempfile.new(['key', '.pem'], Rails.root.to_s + '/tmp/')
 
        open public.path, 'w' do |io| io.write key.public_key.to_pem 
        end

        pass_phrase = @signature.password
        key_secure = key.export cipher, pass_phrase

        @signature.public_key.attach(io: File.open(public),filename: "key-" + current_user.id.to_s + ".pem",content_type: 'application/x-pem-file')
        @signature.user_id = current_user.id
        @signature.save

        @privates = Tempfile.new(['key', '.secure.pem'], Rails.root.to_s + '/tmp/')

        open @privates.path, 'w' do |io| io.write key_secure end
            
        puts @privates
        
        redirect_to signatures_download_path(path: @privates.path)
    end

    def download
        puts 'DESCARGANDO LLAVE PRIVADA'
        current_user.generatedKeys = true
        current_user.save
        send_file(params[:path], filename:"privatekey.pem", type:"application/x-pem-file")
        #redirect_to signatures_download_path
        #File.delete(params[:path]) if File.exist?(params[:path])
    end

    def signature_params
		params.require(:signature).permit(:password)
	end
end
