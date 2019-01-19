# frozen_string_literal: true

class Window < Gosu::Window
  attr_accessor :scene

  def update
    scene ? scene.update : super
  end

  def draw
    scene ? scene.draw : super
  end

  def button_down(id)
    scene ? scene.button_pressed(id) : super
  end
end
