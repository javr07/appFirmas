class Document < ApplicationRecord
	has_and_belongs_to_many :users
	has_and_belongs_to_many :signatures
	mount_uploader :ruta, DocumentUploader
end
