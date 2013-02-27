define [
  'backbone',
  'core/session',
  'core/layout'
], (Backbone, session, layout) ->

  route_page = (page_name, params = []) ->
    ->
      options = {}
      for param, i in params
        options[param] = arguments[i]
      require [
        "views/pages/#{page_name}"
      ], (Page) ->
        page = new Page(options)
        layout.setPage page

  Router = class extends Backbone.Router

    routes:
      '': 'index'
      'home': 'home'
      'logout': 'logout'
      ':userId': 'profile'

    index: ->
      return @navigate('home', trigger: true) if session.id
      do route_page('index')

    home: route_page('home')
    logout: route_page('logout')
    profile: route_page('profile', ['user_id'])

  new Router