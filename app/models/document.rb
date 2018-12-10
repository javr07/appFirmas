class Document < ApplicationRecord
	has_and_belongs_to_many :users
	has_and_belongs_to_many :signatures
	has_one_attached :file
end
