require [
  'underscore',
  'core/layout',
  'core/router',
  'core/session'
], (_, layout, router, session) ->

  sync = Backbone.sync
  Backbone.sync = (method, model, options = {}) ->
    protocol = location.protocol
    host = location.hostname
    port = 8080
    path = _.result(model, 'url')
    options.url = "#{protocol}//#{host}:#{port}#{path}"
    sync.apply null, [method, model, options]

  session.fetchUser()
  layout.render()
  Backbone.history.start()