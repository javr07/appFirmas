class AddSignedToDocuments < ActiveRecord::Migration[5.2]
  def change
    add_column :documents, :signed, :boolean, default: false
  end
end
