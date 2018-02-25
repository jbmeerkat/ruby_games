# frozen_string_literal: true

module Pong
  # Main game class
  class Game
    include AASM

    aasm no_direct_assignment: true do
      state :menu, initial: true
      state :playing
      state :finished

      event :play do
        transitions from: :menu, to: :playing
      end

      event :finish do
        transitions from: :playing, to: :finished
      end

      event :restart do
        transitions from: :finished, to: :menu
      end
    end

    attr_reader :config, :logger

    def initialize(config:)
      @config = config
      @logger = config.logger

      @font = Gosu::Font.new(12)
    end

    def update
      # do nothing
    end

    def draw
      draw_logs
    end

    def button_pressed(id)
      logger.debug "#{id} was pressed"
    end

    def draw_logs
      y_position = config.window_height - (@font.height * 10)

      logger.messages.last(10).each_with_index do |message, index|
        line_y_position = y_position + (@font.height * index)
        draw_log_message(message.strip, 10, line_y_position)
      end
    end

    private

    def draw_log_message(message, x, y)
      @font.draw(message.strip, x, y, 1, 1.0, 1.0, Gosu::Color::YELLOW)
    end
  end
end
