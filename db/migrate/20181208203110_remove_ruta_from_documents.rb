class RemoveRutaFromDocuments < ActiveRecord::Migration[5.2]
  def change
    remove_column :documents, :ruta, :string
  end
end
