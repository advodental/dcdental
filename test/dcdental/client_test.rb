require "test_helper"
require "dcdental/client"

class Dcdental::ClientTest < Minitest::Test
  def test_that_auth_defined
    client = Dcdental::Client.new

    assert client.respond_to? :auth
  end
end
