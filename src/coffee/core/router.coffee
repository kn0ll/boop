define [
  'backbone',
  'core/session',
  'core/layout'
], (Backbone, session, layout) ->

  load_page = (page_name) ->
    ->
      require [
        "views/pages/#{page_name}"
      ], (Page) ->
        layout.setPage new Page

  Router = class extends Backbone.Router

    routes:
      '': 'index'
      'logout': 'logout'

    index: load_page('index')
    logout: load_page('logout')

  new Router