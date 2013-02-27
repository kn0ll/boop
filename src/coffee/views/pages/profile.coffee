define [
  'backbone.layout',
  'hbs!tmpl/pages/profile',
  'resources/user',
  'views/components/user-boops'
], (Layout, template, User, UserBoops) ->

  class extends Layout
    template: template

    views:
      '.user-boops': ->
        new UserBoops
          collection: @model.boops

    initialize: (options) ->
      super
      if not @model
        @model = new User
          _id: options.user_id
      rerender = _.bind(@render, @)
      @model.fetch success: rerender
      @model.fetchBoops success: rerender