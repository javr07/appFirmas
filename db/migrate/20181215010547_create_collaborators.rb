class CreateCollaborators < ActiveRecord::Migration[5.2]
  def change
    create_table :collaborators do |t|
      t.integer :document_id
      t.integer :user_id

      t.timestamps
    end
  end
end
