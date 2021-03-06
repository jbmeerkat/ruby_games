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

      ECS.logger = logger
      @world = ECS::World.new(
        width: config.window_width,
        height: config.window_height
      )
      @stopwatch = Stopwatch.new(clock: Gosu)

      @menu_window = MenuWindow.new(game: self)
      @game_window = GameWindow.new(game: self)
    end

    def update
      world.update(time_delta: stopwatch.lap)
    end

    def draw
      world.draw
    end

    def button_pressed(id)
      logger.debug { "#{id} was pressed" }
    end

    private

    attr_reader :stopwatch

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

      SetupWorld.new(world: world).call

      stopwatch.start
      game_window.show
    end
  end
end
