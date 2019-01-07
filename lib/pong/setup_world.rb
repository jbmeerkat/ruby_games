# frozen_string_literal: true

# rubocop:disable Metrics/AbcSize, Metrics/MethodLength
# :reek:TooManyStatements
module Pong
  # Setup script
  class SetupWorld
    attr_reader :world

    def initialize(world:)
      @world = world
    end

    def call
      create_net

      create_player(:left)
      create_player(:right)

      create_platform(:left)
      create_platform(:right)

      create_ball

      world.add_system(Pong::Systems::RightPlatformControl.new)
      world.add_system(Pong::Systems::LeftPlatformControl.new)
      world.add_system(Pong::Systems::RenderRectangle.new)
      world.add_system(Pong::Systems::RenderNet.new)
      world.add_system(Pong::Systems::Movement.new)
    end

    private

    def create_net
      net_entity = world.create_entity(:net)
      net_component = Components::Net[sections: (world.height / 20.0).ceil]
      add_component(net_entity, net_component)

      position = Components::Position[x: world.width / 2, y: 0]
      add_component(net_entity, position)
    end

    def create_player(side)
      world.create_entity(:"#{side}_player")
    end

    def create_platform(side)
      platform = world.create_entity(:"#{side}_platform")
      component_class = Components.const_get("#{side.capitalize}Platform")
      component = component_class.new
      position = Components::Position[
        x: platform_x(side),
        y: platform_y,
      ]
      velocity = Components::Velocity[x: 0, y: 0]
      add_component(platform, component)
      add_component(platform, position)
      add_component(platform, velocity)
      add_component(platform, Components::Rectangle[
        position: position,
        width: platform_width,
        height: platform_height
      ])
    end

    def create_ball
      ball = world.create_entity(:ball)
      width = world.width
      height = world.height

      position = Components::Position[
        x: width / 2,
        y: height / 2,
      ]
      add_component(ball, position)

      velocity = Components::Velocity[
        x: 200,
        y: 200
      ]
      add_component(ball, velocity)

      ball_side_size = width / 100 * 1
      add_component(ball, Components::Rectangle[
        position: position,
        width: ball_side_size,
        height: ball_side_size
      ])
    end

    def add_component(entity, component)
      world.entity_registry.add_component(entity, component)
    end

    def platform_x(side)
      case side
      when :left
        0
      when :right
        world.width - platform_width
      end
    end

    def platform_y
      world.height / 2 - platform_height / 2
    end

    def platform_width
      world.width / 100 * 1
    end

    def platform_height
      world.height / 100 * 10
    end
  end
end
# rubocop:enable Metrics/AbcSize, Metrics/MethodLength
