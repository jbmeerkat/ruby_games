# frozen_string_literal: true

require 'simplecov'
SimpleCov.start do
  add_filter 'spec/'

  add_group 'ECS', 'lib/ecs'
end

require 'ecs'

ECS.logger = Logger.new('log/test.log')
