define [
  'backbone.layout',
  'hbs!tmpl/components/sign-up'
], (Layout, template) ->

  class extends Layout
    template: template