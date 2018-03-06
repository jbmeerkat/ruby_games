# frozen_string_literal: true

require 'securerandom'

module ECS
  # Entity
  class Entity < String
    # Creates new entity which is frozen string
    def self.create
      new(SecureRandom.uuid).freeze
    end
  end
end
