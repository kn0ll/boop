define [
  'backbone',
  'core/session',
  'core/layout'
], (Backbone, session, layout) ->

  route_page = (page_name) ->
    ->
      require [
        "views/pages/#{page_name}"
      ], (Page) ->
        layout.setPage new Page

  Router = class extends Backbone.Router

    routes:
      '': 'index'
      'home': 'home'
      'logout': 'logout'

    index: ->
      return @navigate('home', trigger: true) if session.id
      do route_page('index')

    home: route_page('home')
    logout: route_page('logout')

  new Router