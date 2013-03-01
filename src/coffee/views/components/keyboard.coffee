define [
  'underscore',
  'core/context',
  'teoria',
  'backbone.layout'
], (_, context, teoria, Layout) ->

  KeyView = class extends Layout
    tagName: 'li'

    events:
      mouseover: 'onMouseenter'
      mouseout: 'onMouseleave'

    onMouseenter: (e) ->
      @model.set 'on', true

    onMouseleave: (e) ->
      @model.set 'on', false

    render: ->
      super
      @$el.text @model.getName()
      @

  KeyboardView = class extends Layout
    tagName: 'ul'
    className: 'keyboard'

    render: ->
      super
      do @$el.empty
      @model.keys.each (key) =>
        view = new KeyView
          model: key
        @$el.append view.render().el
      @

    remove: ->
      super
      @model.disconnect context.output