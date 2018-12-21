require 'test_helper'

class DocumentTest < ActiveSupport::TestCase

  test "create document" do
    document.nombre = 'Prueba'
    document.file = File.new(Rails.root.to_s + '/tmp/prueba.pdf')
    document.descripcion = 'este es un documento de prueba'
    assert document.save
  end

  test "rename document" do
    document.nombre = 'Otro nombre'
    assert document.save
  end

  test "add collaborator to document" do
    user = User.new(nombre: 'Alex')
    users = [user]
    document.users = users
    assert document.save
  end

  test "delete document" do 
    document = Document.find(id: 1)
    assert document.delete
  end
end
