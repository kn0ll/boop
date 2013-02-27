define [
  'backbone'
], (Backbone) ->

  class extends Backbone.Model
    idAttribute: '_id'
    urlRoot: '/boops'
    
    defaults:
      user_id: undefined
      caption: undefined