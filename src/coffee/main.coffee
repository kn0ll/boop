require [
  'underscore',
  'core/layout',
  'core/router'
], (_, layout, router) ->

  sync = Backbone.sync
  Backbone.sync = (method, model, options = {}) ->
    url = _.result(model, 'url')
    options.url = "http://localhost:8080#{url}"
    sync.apply null, [method, model, options]

  layout.render()
  Backbone.history.start()