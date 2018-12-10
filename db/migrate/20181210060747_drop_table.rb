class DropTable < ActiveRecord::Migration[5.2]
  def change
  	drop_table :users_documents
  	create_join_table :users, :documents do |t|
       t.index [:user_id, :document_id]
       t.index [:document_id, :user_id]
    end
  end
end