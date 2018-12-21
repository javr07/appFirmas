require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "create user" do
    user.nombre = 'Alejandro Cámara'
    user.password = '$2a$11$mScWCsyEUIUCI5NWa3Ny1eutDbrDQa6N1bb'
    user.email = 'arcamsoft@gmail.com'
    user.usuario = 'Alex'

    assert user.save
  end

  test "edit user" do
    user = User.find(id:1)
    user.nombre = 'Fernando'
    user.email = 'fer@hotmail.com'
    
    assert user.save
  end
end
