define [
  'underscore',
  'resources/session'
], (_, Session) ->

  Session = class extends Session

    initialize: ->
      super
      @on 'change', _.bind(@cache, @)

    cache: ->
      localStorage.setItem('session', JSON.stringify(@toJSON()))

    destroy: ->
      super
      localStorage.removeItem('session')
      @clear()

  new Session JSON.parse(localStorage.getItem('session'))