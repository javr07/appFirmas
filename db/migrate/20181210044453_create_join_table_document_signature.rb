class CreateJoinTableDocumentSignature < ActiveRecord::Migration[5.2]
  def change
    create_join_table :documents, :signatures do |t|
       t.index [:document_id, :signature_id]
       t.index [:signature_id, :document_id]
    end
  end
end
