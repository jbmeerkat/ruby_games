# frozen_string_literal: true

module ECS
  # Basic system implementation
  #
  # System must implement method +run+ that accepts +time_delta+ keyword
  # argument
  #
  # @see ECS::Systems::Movement#process_tick Movement system implementation
  # @example
  #   class Movement < ECS::Systems::Base
  #     watch_components :velocity, :position
  #     run_on :update
  #
  #     def process_entity(entity, velocity, position)
  #       position.x += velocity.x * time_delta
  #       position.y += velocity.y * time_delta
  #     end
  #   end
  class System
    extend Forwardable
    def_delegators :world, :entity_registry

    attr_accessor :world

    def self.watch_components(*component_names)
      @components = component_names
    end

    def self.run_on(step_name)
      @game_step = step_name
    end

    class << self
      attr_reader :components, :game_step
    end

    # Process one game tick
    #
    # @param time_delta [Numeric] time in milliseconds elapsed since last tick
    def run
      # process_tick(time_delta: world.time_delta)
      entities_with(*self.class.components) do |entity, *components|
        process_entity entity, *components
      end
    end

    # Redefine this method in your system
    #
    # @param [ECS::Entity] entity
    # @param [Array<ECS::Component>] components
    def process_entity(entity, *components)
      raise 'Must be implemented in subclasses'
    end

    # Time delta
    #
    # @return [Integer] milliseconds elapsed from previous tick
    def time_delta
      world.time_delta
    end

    # Returns all entities by specified component names
    #
    # If not block given retuns enumerable, otherwise yields them one by one
    #
    # @api private
    #
    # @param [Array<String>] component_names Component names to
    #   filter entites by
    #
    # @yield [ECS::Entity, Array<ECS::Components::Base>] Yields entity and
    #   array of components in specified order
    def entities_with(*component_names)
      return to_enum(:entities_with) unless block_given?

      entity_registry.with_components(*component_names).each do |entity|
        components = component_names.map { |name| component(entity, name) }
        yield entity, *components
      end
    end

    # Component for entity of specified type
    #
    # @api private
    #
    # @param [ECS::Entity] entity Entity
    # @param [String] component_name Component to find
    #
    # @return [ECS::Component, nil]
    def component(entity, component_name)
      entity_registry.entity_component(entity, component_name)
    end
  end
end
