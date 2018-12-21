require 'test_helper'

class DocumentsControllerTest < ActionDispatch::IntegrationTest
  test "redirect after save" do 
    post "/documents",
    params: { document: { nombre: "nombre del documento", descripción: "descripción de prueba." } }
    assert_response :redirect
    follow_redirect!
  end

  test "redirect after delete" do 
    post "/documents",
    params: { document: { id: 1} }
    assert_response :redirect
    follow_redirect!
  end

  test "redirect after edit" do 
    post "/documents",
    params: { document: { id: 1, nombre: "nombre del documento", descripción: "descripción de prueba."} }
    assert_response :redirect
  end
end
