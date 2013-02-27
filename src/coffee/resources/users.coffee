define [
  'backbone'
], (Backbone) ->

  class extends Backbone.Collection
    url: '/users'