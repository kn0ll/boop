define [
  'backbone',
  'resources/user'
], (Backbone, User) ->

  class extends Backbone.Model
    idAttribute: '_id'
    urlRoot: '/sessions'

    defaults:
      user_id: undefined

    validate: (attrs) ->
      if not attrs.user_id
        'user_id cannot be empty'
      else
        undefined

    save: (attrs, options = {}) ->
      user = new User
        _id: attrs.user_id
      user.fetch
        data:
          password: attrs.password
        success: =>
          delete attrs.password
          Backbone.Model::save.apply @, [attrs, options]
        error: (model) ->
          options.error? model, 'no user with that user_id and password'