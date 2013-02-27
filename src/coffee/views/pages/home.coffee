define [
  'backbone.layout',
  'hbs!tmpl/pages/home'
], (Layout, template) ->

  class extends Layout
    template: template