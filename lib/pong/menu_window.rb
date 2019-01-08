# frozen_string_literal: true

module Pong
  # Main (and the only) game window
  class MenuWindow < Gosu::Window
    FONT_PATH = ::Pong.root.join('assets', 'fonts', 'visitor.ttf').to_s

    attr_reader :config, :game

    def initialize(game:)
      @config = config
      @game = game

      width = game.config.window_width
      height = game.config.window_height

      super width, height

      self.caption = game.config.window_caption
    end

    def draw
      draw_header
      draw_instructions
      draw_info
    end

    def button_down(_)
      game.play
    end

    def draw_header
      font = Gosu::Font.new(80, name: FONT_PATH)
      text = 'Pong'
      x = (width / 2) - (font.text_width(text) / 2)

      font.draw_text(text, x, height * 0.3, 1, 1.0, 1.0, Gosu::Color::WHITE)
    end

    def draw_instructions
      font = Gosu::Font.new(30, name: FONT_PATH)
      text = 'Press any key to start'

      blink(seconds: 1) do
        x = (width / 2) - (font.text_width(text) / 2)
        font.draw_text(text, x, height * 0.6, 1, 1.0, 1.0, Gosu::Color::WHITE)
      end
    end

    def draw_info
      font = Gosu::Font.new(17, name: FONT_PATH)
      text = %w[
        Created by Alex Klyanchin.
        Source code at github.com/jbmeerkat/pong'
      ].join(' ')

      x = (width / 2) - (font.text_width(text) / 2)
      font.draw_text(text, x, height - font.height, 1, 1.0, 1.0,
        Gosu::Color::GRAY)
    end

    def blink(seconds:)
      seconds_in_millis = seconds * 1000
      return unless (milliseconds_elapsed / seconds_in_millis).even?

      yield
    end

    def milliseconds_elapsed
      Gosu.milliseconds
    end
  end
end
