# frozen_string_literal: true

module ECS
  # Main component of ECS
  class World
    extend Forwardable
    def_delegators :@entity_registry, :create_entity

    attr_reader :entity_registry, :systems

    def initialize(entity_registry: EntityRegistry.new)
      @entity_registry = entity_registry
      @systems = []
    end

    # Adds system to systems list
    # Every system will be started every game tick to process changes
    #
    # @param [ECS::Systems::Base] system System to add
    def add_system(system)
      raise 'System already added' if systems.include?(system)

      systems << system

      system.world = self
    end

    # Triggers each system in order to process game tick
    #
    # @param [Integer] time_delta Milliseconds elapsed
    def update(time_delta:)
      systems.each do |system|
        system.run(time_delta: time_delta)
      end
    end
  end
end
