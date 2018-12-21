class Document < ApplicationRecord
	has_many :signatures
	belongs_to :user
	has_many :collaborators
	has_one_attached :file 
	has_one :documentHash

	validates :nombre, presence: {message: ": El nombre del documento es obligatorio"}, length: {maximum: 255, too_long: "El número de caracteres máximo es de 255"}
	validates :descripcion, presence: {message: ": La descripción es obligatoria"}, on: :create
	validates :file, attached: true, content_type: {in: 'application/pdf', message: 'solo puedes subir pdf'}

	attr_accessor :privateKey
  	attr_accessor :password

	after_save :save_user

	def users=(value)
    	@users = value
  	end

	private 
	def save_user
    	begin
    	@users.each do |user_id|
      		Collaborator.create(user_id: user_id, document_id: self.id)
    	end
    	rescue
      		end
	  end
	  
end
