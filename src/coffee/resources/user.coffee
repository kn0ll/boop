define [
  'underscore',
  'backbone',
  'resources/boops'
], (_, Backbone, Boops) ->

  class extends Backbone.Model
    idAttribute: '_id'
    urlRoot: '/users'

    defaults:
      username: undefined
      email: undefined
      password: undefined

    validate: (attrs) ->
      if not attrs.username
        'username cannot be empty'
      else if not attrs.email
        'email cannot be empty'
      else if not attrs.password
        'password cannot be empty'
      else
        undefined

    initialize: ->
      super
      @boops = new Boops
      @boops.fetch = _.bind(@fetchBoops, @)

    fetchBoops: (options = {}) ->
      options.data ?= {}
      options.data.user_id = @id
      Boops::fetch.apply @boops, options