# frozen_string_literal: true

module ECS
  # Registry of all entities
  class EntityRegistry
    include Logging

    attr_reader :world, :entities, :entities_by_tag, :entity_components,
      :component_entities

    # :reek:DuplicateMethodCall
    def initialize(world:)
      @world = world
      @entities = []
      @entities_by_tag = Hash.new { |hash, key| hash[key] = [] }
      @entity_components = Hash.new { |hash, key| hash[key] = [] }
      @component_entities = Hash.new { |hash, key| hash[key] = [] }
    end

    def create_entity(tag = nil)
      logger.debug { "Creating entity with tag=#{tag} ..." }

      entity = Entity.create
      register(entity, tag)

      logger.debug { "Entity #{entity} was created" }

      entity
    end

    def add_component(entity, component)
      entity_components[entity] << component
      component_entities[component.name] << entity

      logger.debug { "Component #{component.inspect} was added to #{entity}" }

      component
    end

    def with_components(*component_names)
      component_names.map do |component_name|
        component_entities[component_name]
      end.inject(:&) || []
    end

    def entity_component(entity, component_name)
      entity_components[entity].detect do |component|
        component.name == component_name
      end
    end

    private

    def register(entity, tag)
      entities << entity
      entities_by_tag[tag] << entity if tag
    end
  end
end
