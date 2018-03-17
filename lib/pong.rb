# frozen_string_literal: true

require_relative 'pong/version'
require_relative 'pong/config'
require_relative 'pong/setup_world'
require_relative 'pong/game'

require_relative 'ecs'
require_relative 'pong/components'
require_relative 'pong/systems'

# Pong game's root module
module Pong
  DEFAULT_CONFIG = {
    logger: Logger.new(STDOUT, progname: 'pong'),
    window_width: 1024,
    window_height: 768,
    window_caption: 'Pong'
  }.freeze

  module_function

  def start(config: DEFAULT_CONFIG)
    config = Config.new(config)
    game = Game.new(config: config)

    game.start
  end

  def root
    Pathname.new(File.expand_path('..', __dir__))
  end
end

require_relative 'pong/menu_window'
require_relative 'pong/game_window'
