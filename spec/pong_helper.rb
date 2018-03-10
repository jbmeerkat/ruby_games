# frozen_string_literal: true

require 'aasm/rspec'

require 'simplecov'
SimpleCov.start do
  add_filter 'spec/'

  # TODO: find a good way to isolate Gosu from windows and
  # run windows' test on CI
  add_filter 'lib/pong/menu_window.rb'
  add_filter 'lib/pong/game_window.rb'

  add_group 'Pong', 'lib/pong'
end

require 'pong'

FileUtils.mkdir_p(Pong.root.join('log'))
