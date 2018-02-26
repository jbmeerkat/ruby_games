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
      # do nothing
    end

    def button_pressed(id)
      logger.debug "#{id} was pressed"
    end
  end
end
