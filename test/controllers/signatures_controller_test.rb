require 'test_helper'

class SignaturesControllerTest < ActionDispatch::IntegrationTest
  test "redirect after sign" do 
    post "/documents/sign",
    params: { singature: { documentid: 1 } }
    assert_response :redirect
    follow_redirect!
  end
end
