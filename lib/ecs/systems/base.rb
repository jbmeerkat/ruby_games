# frozen_string_literal: true

module ECS
  module Systems
    # Basic system implementation
    #
    # System must implement method +run+ that accepts +time_delta+ keyword
    # argument
    #
    # @see ECS::Systems::Movement#process_tick Movement system implementation
    # @example
    #   class Movement < ECS::Systems::Base
    #     def process_tick(time_delta:)
    #       entities_with(:velocity, :position) do |_, (velocity, position)|
    #         position.x = velocity.x * time_delta
    #         position.y = velocity.y * time_delta
    #       end
    #     end
    #   end
    class Base
      extend Forwardable
      def_delegators :world, :entity_registry

      attr_accessor :world

      # Process one game tick
      #
      # @param time_delta [Numeric] time in milliseconds elapsed since last tick
      def run(time_delta:)
        process_tick(time_delta: time_delta)
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
end
