define [
  'backbone.layout',
  'hbs!tmpl/pages/logout',
  'core/session'
], (Layout, template, session) ->

  class extends Layout
    template: template

    initialize: ->
      super
      session.destroy()