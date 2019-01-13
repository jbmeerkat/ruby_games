# frozen_string_literal: true

# Game selection
module Games
  FONT_PATH = Pathname.new(File.expand_path('..', __dir__))
    .join('assets', 'fonts', 'visitor.ttf').to_s
  MENU_OPTIONS = [
    { text: 'Pong', state: :active, program: -> { run_pong } },
    { text: 'Snake', state: :active, program: -> { run_snake } },
    { text: 'Breakout', state: :inactive },
    { text: 'Missile Control', state: :inactive },
    { text: 'Space Invaders', state: :inactive },
    { text: 'Asteroids', state: :inactive },
    { text: 'Tetris', state: :inactive },
    { text: 'Pacman', state: :inactive },
    { text: 'Ikari Warriors', state: :inactive },
    { text: 'Super Mario Bros', state: :inactive }
  ].freeze

  # Window with games list
  class Window < Gosu::Window
    attr_reader :menu

    def initialize(menu:)
      @menu = menu

      super 1024, 768

      self.caption = 'Old school games'
    end

    def update; end

    def draw
      draw_header
      menu.render
    end

    def button_down(id)
      case id
      when Gosu::KB_DOWN
        menu.next
        select_sound.play
      when Gosu::KB_UP
        menu.previous
        select_sound.play
      when Gosu::KB_RETURN
        menu.select
      end
    end

    def draw_header
      font = Gosu::Font.new(80, name: FONT_PATH)
      text = 'Old school games'
      x = (width / 2) - (font.text_width(text) / 2)

      font.draw_text(text, x, height * 0.3, 1, 1.0, 1.0, Gosu::Color::WHITE)
    end

    def select_sound
      @select_sound ||= Gosu::Sample.new('assets/sounds/menu.wav')
    end
  end

  # Games menu
  class Menu
    OPTION_COLOR = {
      active: Gosu::Color::WHITE,
      inactive: Gosu::Color::GRAY
    }.freeze

    def initialize(options:)
      @options = options
      @selected = 0
    end

    def next
      return unless can_select_next?

      @selected += 1
    end

    def previous
      return unless can_select_previous?

      @selected -= 1
    end

    def select
      @options[@selected][:program].call
    end

    def render
      @options.each.with_index do |option, index|
        y = 332 + index * 30
        draw_text('>', 320, y) if index == @selected
        draw_centered(option[:text], y, state: option[:state])
      end
    end

    private

    def can_select_next?
      next_option = @options[@selected + 1]

      next_option && next_option[:state] == :active
    end

    def can_select_previous?
      @selected <= 0
    end

    def draw_centered(text, y, state: :active)
      x = 512 - font.text_width(text) / 2

      draw_text(text, x, y, state: state)
    end

    def draw_text(text, x, y, state: :active)
      font.draw_text(text, x, y, 1, 1.0, 1.0, OPTION_COLOR.fetch(state))
    end

    def font
      @font ||= Gosu::Font.new(30, name: Games::FONT_PATH)
    end
  end

  module_function

  def start
    menu = Menu.new(
      options: MENU_OPTIONS
    )

    window = Window.new(menu: menu)

    window.show
  end

  def run_pong
    require_relative 'pong'

    Pong.start
  end

  def run_snake
    require_relative 'snake'

    Snake.start
  end
end
