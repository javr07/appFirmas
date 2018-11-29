class DocumentsController < ApplicationController
	def index
		@documents = Document.all
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
			redirect_to @document
		else 
			render 'new'	
		end
	end
	def document_params
		params.requiere(:document).permit(:nombre, :ruta)
	end
end
