define [
  'audiolet',
  'core/context'
], (Audiolet, context) ->

  class extends PassThroughNode

    constructor: (audiolet, numInputs, numOutputs) ->
      super
      @cache = []
      for i in [0..numInputs-1]
        @cache[i] = []

    createOutputSamples: ->
      super
      if @recording
        for i in [0..@inputs.length-1]
          for sample in @inputs[i].samples
            @cache[i].push sample

    record: ->
      @recording = true
      @cache

    stop: ->
      @recording = false
      @cache