define [
  'backbone.layout',
  'core/session',
  'hbs!tmpl/layout/index',
  'views/layout/nav'
], (Layout, session, template, Nav) ->

  class extends Layout
    template: template

    views:
      '.nav': ->
        new Nav
          model: session

    setPage: (view) ->
      this.setView('.page', view)