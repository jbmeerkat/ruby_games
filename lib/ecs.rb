# frozen_string_literal: true

require_relative 'ecs/ext/dry/struct/mutable'
require_relative 'ecs/logging'
require_relative 'ecs/world'
require_relative 'ecs/entity'
require_relative 'ecs/entity_registry'
require_relative 'ecs/component'
require_relative 'ecs/system'

# Entity-component-system framework
# https://en.wikipedia.org/wiki/Entity%E2%80%93component%E2%80%93system
module ECS
  module_function

  def logger=(logger)
    @logger = logger
  end

  def logger
    @logger ||= Logger.new(STDOUT)
  end
end
