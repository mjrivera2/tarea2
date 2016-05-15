require 'test_helper'

class ApplicationTest < ActiveSupport::TestCase
   test "the truth" do
     assert false
   end
  test "Cantidad_Imagenes" do
    get '/instagram/snow/buscar'

    json = JSON.parse(response.body)
    assert_equal(json["data"].length, 20)
  end


end