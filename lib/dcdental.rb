# frozen_string_literal: true

require_relative 'dcdental/version'
require_relative 'dcdental/api'
require_relative 'dcdental/client'
require_relative 'dcdental/configuration'
require_relative 'dcdental/core_ext/string'
require_relative 'dcdental/core_ext/hash'

# Dcdental
module Dcdental
  class ApiError < StandardError; end

  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset
    @configuration = Configuration.new
  end

  def self.new
    ::Dcdental::Client.new
  end

  def self.configure
    yield(configuration)
  end
end
