class DocumentsController < ApplicationController
	def index
		@documents = User.find(current_user.id).documents
	end
	def show
		@document = Document.find(params[:id])
	end
	def new
		@document = Document.new
	end
	def create
		@document = Document.new(document_params)
		if @document.save
			@document.users << current_user
			redirect_to @documents
		else 
			render 'new'	
		end
	end
	def document_params
		params.require(:document).permit(:nombre, :file, :descripcion)
	end
end
