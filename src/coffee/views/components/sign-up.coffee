define [
  'backbone.layout',
  'hbs!tmpl/components/sign-up'
  'underscore',
  'jquery.serializeForm',
  'core/session',
  'resources/user',
  'core/router'
], (Layout, template, _, serializeForm, session, User, router) ->

  class extends Layout
    template: template

    events:
      'submit': 'onSubmit'

    onSubmit: (e) ->
      e.preventDefault()
      return alert 'you\'re logged in already' if session.id
      attrs = serializeForm(@$el)

      # try creating user
      user = new User
      user.on 'invalid', _.bind(@onInvalid, @)
      user.save attrs,

        # sign-in after successful sign-up
        success: ->
          session_attrs =
            user_id: user.id
            password: attrs.password
          session.save session_attrs,
            success: ->
              router.navigate 'home', trigger: true
            error: (model, xhr) ->
              err = xhr.responseText or xhr
              alert "#{err}"

        error: (model, xhr) ->
          err = xhr.responseText or xhr
          alert "#{err}"

    onInvalid: (err) ->
      alert err.validationError