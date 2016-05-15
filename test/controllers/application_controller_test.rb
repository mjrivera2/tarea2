require 'test_helper'

class ApplicationControllerTest < ActionController::TestCase

  test "true" do
    assert true
  end

  test "code_200_with_correct_params" do
    post :buscar, :tag => 'snow', :access_token => '9994244.1fb234f.8893dfbb48d840aab8ea4b3e92be20e7'
    assert_equal 200, response.status
  end

  test "code_400_with_incorrect_params" do
    post :buscar, :tags => 'snow', :access_token => '9994244.1fb234f.8893dfbb48d840aab8ea4b3e92be20e7'
    assert_equal 400, response.status
  end
  test "image_count" do
    @tags_json = HTTParty.get('https://api.instagram.com/v1/tags/snow/media/recent?access_token=9994244.1fb234f.8893dfbb48d840aab8ea4b3e92be20e7&count=20')
    assert_equal 20, @tags_json["data"].length
  end
end