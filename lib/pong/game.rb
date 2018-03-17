# frozen_string_literal: true

module Pong
  # Main game class
  class Game
    include AASM

    aasm no_direct_assignment: true do
      state :inactive, initial: true
      state :menu
      state :playing
      state :finished

      after_all_transitions :log_state_change

      event :start, after: :show_menu do
        transitions from: :inactive, to: :menu
      end

      event :play, after: :start_playing do
        transitions from: :menu, to: :playing
      end

      event :finish do
        transitions from: :playing, to: :finished
      end

      event :restart do
        transitions from: :finished, to: :menu
      end
    end

    attr_reader :config, :logger, :world, :menu_window, :game_window

    def initialize(config:)
      @config = config
      @logger = config.logger

      @world = ECS::World.new(
        width: config.window_width,
        height: config.window_height,
        logger: logger
      )
      @previous_delta = 0

      @menu_window = MenuWindow.new(game: self)
      @game_window = GameWindow.new(game: self)
    end

    def update
      world.update(time_delta: time_delta)
    end

    def draw
      world.draw
    end

    def button_pressed(id)
      logger.debug "#{id} was pressed"
    end

    private

    attr_accessor :previous_delta

    def log_state_change
      from = aasm.from_state
      to = aasm.to_state
      event = aasm.current_event

      logger.info(
        "Game state is changing from #{from} to #{to} (event: #{event})"
      )
    end

    def show_menu
      menu_window.show
    end

    def start_playing
      menu_window.close

      setup_world

      game_window.show
    end

    def setup_world
      left_platform = world.create_entity('left_platform')
      world.entity_registry
        .add_component(left_platform, Components::Rectangle[])
      world.add_system(Pong::Systems::RenderRectangle.new)
    end

    def time_delta
      current_delta = Gosu.milliseconds - previous_delta
      self.previous_delta = previous_delta + current_delta

      current_delta
    end
  end
end
