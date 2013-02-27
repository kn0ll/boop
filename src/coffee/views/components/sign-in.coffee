define [
  'backbone.layout',
  'hbs!tmpl/components/sign-in',
  'core/session',
  'jquery.serializeForm'
], (Layout, template, session, serializeForm) ->

  class extends Layout
    template: template

    events:
      'submit': 'onSubmit'

    initialize: ->
      super
      @listenTo session, 'invalid', _.bind(@onInvalid, @)

    onSubmit: (e) ->
      e.preventDefault()
      return alert 'you\'re logged in already' if session.id

      # try creating session
      session.save serializeForm(@$el),
        success: ->
          console.log 'u r logged in man'
        error: (model, xhr) ->
          err = xhr.responseText or xhr
          alert "#{err}"

    onInvalid: (err) ->
      alert err.validationError