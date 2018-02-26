# frozen_string_literal: true

require_relative 'pong/version'
require_relative 'pong/config'
require_relative 'pong/main_window'
require_relative 'pong/game'

# Pong game's root module
module Pong
  DEFAULT_CONFIG = {
    logger: Logger.new(STDOUT),
    window_width: 1024,
    window_height: 768,
    window_caption: 'Pong'
  }.freeze

  module_function

  def start(config: DEFAULT_CONFIG)
    config = Config.new(config)
    game = Game.new(config: config)
    game_window = MainWindow.new(game: game)

    game_window.show
  end
end
