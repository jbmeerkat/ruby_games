# frozen_string_literal: true

module Snake
  class GameWindow
    attr_reader :game

    def initialize(game:)
      @game = game
    end

    def draw
      game.draw
    end

    def update
      game.update
    end

    def button_down(id)
      game.event_bus.publish(:button_pressed, id: id)
    end
  end
end
