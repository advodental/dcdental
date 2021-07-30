# frozen_string_literal: true

require_relative 'dcdental/version'
require_relative 'dcdental/api'
require_relative 'dcdental/client'
require_relative 'dcdental/configuration'

# Dcdental
module Dcdental
  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset
    @configuration = Configuration.new
  end

  def new
    Dcdental::Client.new
  end

  def self.configure
    yield(configuration)
  end
end
