define [
  'backbone.layout',
  'hbs!tmpl/pages/profile',
  'resources/user'
], (Layout, template, User) ->

  class extends Layout
    template: template

    initialize: (options) ->
      super
      if not @model
        @model = new User
          _id: options.user_id
      @model.fetch
        success: _.bind(@render, @)