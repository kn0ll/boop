define [
  'core/context'
  'underscore',
  'backbone'
], (context, _, Backbone) ->

  Key = class extends Backbone.Model

    defaults:
      on: false
      key: 'C'
      octave: 4

    getName: ->
      @get('key') + @get('octave')

  Keys = class extends Backbone.Collection

    model: Key

  class extends Backbone.Model

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