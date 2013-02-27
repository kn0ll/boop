define [
  'core/context',
  'teoria',
  'backbone.layout',
  'hbs!tmpl/components/create-boop',
  'core/session',
  'resources/boop'
], (context, teoria, Layout, template, session, Boop) ->

  Key = class extends Backbone.Model

    defaults:
      on: false
      key: 'C'
      octave: 4

    getName: ->
      @get('key') + @get('octave')

  Keys = class extends Backbone.Collection

    model: Key

  Keyboard = class extends Backbone.Model

    defaults:
      keys: ['C', 'D', 'G']
      octaves: [3, 4]

    initialize: ->
      super
      keys = []
      for octave in @get 'octaves'
        for key in @get 'keys'
          keys.push
            key: key
            octave: octave
      @keys = new Keys keys
      @output = new PassThroughNode context, 1, 1
      @keys.on 'change:on', _.bind(@keyChanged, @)

    keyChanged: (key, key_on) ->
      if key_on
        note = teoria.note(key.getName())
        osc = new Sine context, note.fq()
        osc.connect @output
        key.osc = osc
      else if key.osc
        key.osc.disconnect @output

    connect: (dest) ->
      @output.connect dest

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

    initialize: ->
      super
      @model = new Keyboard
      @model.connect context.output

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

  class extends Layout
    template: template

    views:
      '.keyboard': ->
        new KeyboardView

    events:
      'submit': 'formSubmit'

    formSubmit: (e) ->
      boop = new Boop
        user_id: session.id,
        caption: @$('.caption').val()
      boop.save()
      e.preventDefault()