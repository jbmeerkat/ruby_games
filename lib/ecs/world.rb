# frozen_string_literal: true

module ECS
  # Main component of ECS
  class World
    extend Forwardable
    def_delegators :@entity_registry, :create_entity

    attr_reader :width, :height, :logger, :entity_registry
    attr_reader :update_systems, :draw_systems
    attr_accessor :time_delta

    def initialize(width:, height:, logger: nil, entity_registry: nil)
      @width = width
      @height = height
      @logger = logger || Logger.new(STDOUT)
      @entity_registry = entity_registry || EntityRegistry.new
      @update_systems = Set.new
      @draw_systems = Set.new

      logger.info do
        %(Initializing world with width=#{width} height=#{height}
          entity_registry=#{entity_registry}")
      end
    end

    # Adds system to systems list
    # Every system will be started every game tick to process changes
    #
    # @param [ECS::Systems::Base] system System to add
    def add_system(system)
      logger.debug { "Adding system #{system}" }

      step = system.class.game_step
      registry_for(step) << system
      system.world = self

      logger.debug { "System #{system} was added to game step #{step}" }
    end

    # Triggers each system in order to process game tick
    #
    # @param [Integer] time_delta Milliseconds elapsed
    def update(time_delta:)
      self.time_delta = time_delta

      update_systems.each(&:run)
    end

    def draw
      draw_systems.each(&:run)
    end

    private

    def registry_for(step)
      case step
      when :draw
        draw_systems
      when :update
        update_systems
      else
        raise ArgumentError, "Unknown game step #{system.class.game_step}"
      end
    end
  end
end
