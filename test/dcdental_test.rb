# frozen_string_literal: true

require 'test_helper'

class DcdentalTest < Minitest::Test
  def setup
    Dcdental.configure do |config|
      config.consumer_key = 'consumer_key'
      config.consumer_secret = 'consumer_secret'
      config.token_id = 'token_id'
      config.token_secret = 'token_secret'
    end
  end

  def test_that_it_has_a_version_number
    refute_nil ::Dcdental::VERSION
  end

  def test_that_configuration_has_correct_values
    assert_equal 'consumer_key', Dcdental.configuration.consumer_key
    assert_equal 'consumer_secret', Dcdental.configuration.consumer_secret
    assert_equal 'token_id', Dcdental.configuration.token_id
    assert_equal 'token_secret', Dcdental.configuration.token_secret
  end

  def test_that_configration_can_be_reseted
    Dcdental.reset
    assert_nil Dcdental.configuration.consumer_key
    assert_nil Dcdental.configuration.consumer_secret
    assert_nil Dcdental.configuration.token_id
    assert_nil Dcdental.configuration.token_secret
  end
end
