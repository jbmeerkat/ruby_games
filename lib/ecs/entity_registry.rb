# frozen_string_literal: true

module ECS
  # Registry of all entities
  class EntityRegistry
    attr_reader :entities, :entities_by_tag, :entity_components,
      :component_entities

    def initialize
      @entities = []
      @entities_by_tag = Hash.new { |hash, key| hash[key] = [] }
      @entity_components = Hash.new { |hash, key| hash[key] = [] }
      @component_entities = Hash.new { |hash, key| hash[key] = [] }
    end

    def create_entity(tag = nil)
      entity = Entity.create
      entities << entity
      entities_by_tag[tag] << entity

      entity
    end

    def add_component(entity, component)
      entity_components[entity] << component
      component_entities[component.name] << entity

      component
    end

    def with_components(*component_names)
      component_names.map do |component_name|
        component_entities[component_name]
      end.inject(:&)
    end

    def entity_component(entity, component_name)
      entity_components[entity].detect do |component|
        component.name == component_name
      end
    end
  end
end
