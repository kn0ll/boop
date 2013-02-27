define [
  'underscore',
  'backbone'
], (_, Backbone) ->

  class extends Backbone.View
    tagName: 'ul'

    initialize: ->
      super
      @collection.on('reset', _.bind(@render, @))
      @collection.on('add', _.bind(@addItem, @))

    render: ->
      super
      $el = @$el
      $el.empty()
      @collection.each(_.bind(@addItem, @))
      @

    addItem: (log) ->
      $el = @$el
      $el.prepend('<li>' + log.get('caption') + '</li>')
      @