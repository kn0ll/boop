define [
  'backbone.layout',
  'hbs!tmpl/pages/new',
  'views/components/create-boop'
], (Layout, template, CreateBoop) ->

  class extends Layout
    template: template

    views:
      '.create-boop': ->
        new CreateBoop