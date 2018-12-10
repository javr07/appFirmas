class CreateUsersDocuments < ActiveRecord::Migration[5.2]
  def change
    create_table :users_documents, id: false do |t|
    	t.belongs_to :user, index: true
    	t.belongs_to :document, index: true
    end
  end
end
