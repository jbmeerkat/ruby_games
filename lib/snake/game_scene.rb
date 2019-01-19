# frozen_string_literal: true

module Snake
  class GameScene
    attr_reader :game

    def initialize(game:)
      @paused = false
      @game = game
    end

    def pause
      @paused = true
    end

    def paused?
      @paused
    end

    def draw
      return if paused?
    end

    def update
      return if paused?
    end

    def button_pressed(id)
      return if paused?

      game.logger.info("Pressed #{id}")
    end
  end
end
