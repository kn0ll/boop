define [
  'underscore',
  'backbone.layout',
  'hbs!tmpl/layout/nav'
], (_, Layout, template) ->

  class extends Layout
    template: template

    initialize: ->
      super
      @model.on 'change', _.bind(@render, @)