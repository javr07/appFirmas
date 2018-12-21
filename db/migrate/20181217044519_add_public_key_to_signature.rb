class AddPublicKeyToSignature < ActiveRecord::Migration[5.2]
  def change
    add_column :signatures, :publicKey, :text
  end
end
