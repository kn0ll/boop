define [
  'backbone.layout',
  'hbs!tmpl/components/sign-in',
  'core/session',
  'jquery.serializeForm',
  'core/router'
], (Layout, template, session, serializeForm, router) ->

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
          router.navigate 'home', trigger: true

        error: (model, xhr) ->
          err = xhr.responseText or xhr
          alert "#{err}"

    onInvalid: (err) ->
      alert err.validationError