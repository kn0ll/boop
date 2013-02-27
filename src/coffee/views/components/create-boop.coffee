define [
  'backbone.layout',
  'hbs!tmpl/components/create-boop',
  'core/session',
  'resources/boop'
], (Layout, template, session, Boop) ->

  class extends Layout
    template: template

    events:
      'submit': 'formSubmit'

    formSubmit: (e) ->
      boop = new Boop
        user_id: session.id,
        caption: @$('.caption').val()
      boop.save()
      e.preventDefault()