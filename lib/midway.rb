require 'yaml'

require "midway/version"
require 'midway/cli'
require 'midway/ssh'

module Midway

  def self.config
    @config ||= YAML.load_file(config_path)
  end

  def self.config_path
    File.expand_path('~/.midway.yml')
  end
end
