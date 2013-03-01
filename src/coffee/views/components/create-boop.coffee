define [
  'handlebars',
  'underscore',
  'core/context',
  'backbone.layout',
  'hbs!tmpl/components/create-boop',
  'core/session',
  'resources/boop',
  'audio/recorder',
  'audio/keyboard',
  'views/components/keyboard',
  'core/router',
  'wavencoder'
], (Handlebars, _, context, Layout, template, session, Boop,
  Recorder, Keyboard, KeyboardView, router, wavEncoder) ->

  RecordButton = class extends Layout
    tagName: 'button'

    template: Handlebars.compile """
      {{#if recording}}
        stop recording
      {{else}}
        record
      {{/if}}
    """

    events:
      'click': 'record'

    view: ->
      recording: @model.recording

    record: (e) ->
      r = @model
      if r.recording
        r.stop()
      else
        r.record()
      @render()
      e.preventDefault()

  class extends Layout
    template: template

    views:
      '.record': ->
        new RecordButton
          model: @recorder
      '.keyboard': ->
        new KeyboardView
          model: @keyboard

    events:
      'submit': 'formSubmit'

    initialize: ->
      super
      @model = new Boop
        user_id: session.get('user_id')
      @keyboard = new Keyboard
      @recorder = new Recorder context, 1, 1
      @keyboard.connect @recorder
      @recorder.connect context.output

    formSubmit: (e) ->
      attrs = 
        title: @$('.title').val()
        dataUri: wavEncoder.encode(@recorder.cache[0], {
          numChannels: context.numberOfChannels,
          sampleRateHz: context.sampleRate,
          bytesPerSample: context.output.device.sink.quality
        })
      @model.save attrs,
        success: ->
          router.navigate session.get('user_id'), trigger: true
      e.preventDefault()