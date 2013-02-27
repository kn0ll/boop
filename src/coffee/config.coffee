require.config
  name: 'config'
  deps: ['main']
  baseUrl: 'js'

  paths:
    'jquery': 'lib/jquery'
    'jquery.serializeForm': 'lib/jquery.serializeForm'
    'underscore': 'lib/underscore'
    'backbone': 'lib/backbone'
    'backbone.subscribe': 'lib/backbone.subscribe'
    'backbone.layout': 'lib/backbone.layout'
    'socket.io': 'lib/socket.io'
    'handlebars': 'lib/handlebars'
    'hbs': 'lib/require.handlebars'
    'tmpl': '../hbs'

  shim:

    'jquery':
      exports: 'jQuery'

    'jquery.serializeForm':
      exports: 'jQuery.serializeForm'

    'underscore':
      exports: '_'

    'backbone':
      deps: ['jquery', 'underscore']
      exports: 'Backbone'

    'backbone.subscribe':
      deps: ['jquery', 'backbone', 'socket.io']
      exports: 'Backbone.subscribe'

    'backbone.layout':
      deps: ['backbone']
      exports: 'Backbone.Layout'

  hbs:
    disableI18n: true