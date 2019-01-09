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

      create_racket(:left)
      create_racket(:right)

      create_ball

      world.add_system(Pong::Systems::RightRacketControl.new)
      world.add_system(Pong::Systems::LeftRacketControl.new)
      world.add_system(Pong::Systems::RenderRectangle.new)
      world.add_system(Pong::Systems::RenderNet.new)
      world.add_system(Pong::Systems::Movement.new)
      world.add_system(Pong::Systems::Ball.new)
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

    def create_racket(side)
      racket = world.create_entity(:"#{side}_racket")
      component_class = Components.const_get("#{side.capitalize}Racket")
      component = component_class.new
      position = Components::Position[
        x: racket_x(side),
        y: racket_y,
      ]
      velocity = Components::Velocity[x: 0, y: 0]
      add_component(racket, component)
      add_component(racket, position)
      add_component(racket, velocity)
      add_component(racket, Components::Rectangle[
        position: position,
        width: racket_width,
        height: racket_height
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

    def racket_x(side)
      case side
      when :left
        0
      when :right
        world.width - racket_width
      end
    end

    def racket_y
      world.height / 2 - racket_height / 2
    end

    def racket_width
      world.width / 100 * 1
    end

    def racket_height
      world.height / 100 * 10
    end
  end
end
# rubocop:enable Metrics/AbcSize, Metrics/MethodLength
