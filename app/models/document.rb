class Document < ApplicationRecord
	has_many :signatures
	belongs_to :user
	has_many :collaborators
	has_one_attached :file

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
