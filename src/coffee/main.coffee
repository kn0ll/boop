require [
  'underscore',
  'core/layout',
  'core/router',
  'core/session'
], (_, layout, router, session) ->

  # override Backbone.sync so we can hit our API
  # on the same host, but a different port
  sync = Backbone.sync
  Backbone.sync = (method, model, options = {}) ->
    protocol = location.protocol
    host = location.hostname
    port = 8080
    path = _.result(model, 'url')
    options.url = "#{protocol}//#{host}:#{port}#{path}"
    sync.apply null, [method, model, options]

  # try getting logged in user on load
  session.fetchUser()

  # whenever the session changes users we
  # should try to fetch the new user
  session.on 'change:user_id', ->
    session.fetchUser()

  # render initial layout
  layout.render()

  # start router handling
  Backbone.history.start()