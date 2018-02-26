# frozen_string_literal: true

module Pong
  # Main (and the only) game window
  class GameWindow < Gosu::Window
    attr_reader :config, :game

    def initialize(game:)
      @config = config
      @game = game

      width = game.config.window_width
      height = game.config.window_height

      super width, height

      self.caption = game.config.window_caption
    end

    def update
      game.update
    end

    def draw
      game.draw
    end

    def button_down(id)
      game.button_pressed(id)
    end
  end
end
