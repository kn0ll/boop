define [
  'backbone.layout',
  'hbs!tmpl/pages/index',
  'views/components/sign-in',
  'views/components/sign-up'
], (Layout, template, SignIn, SignUp) ->

  class extends Layout
    template: template

    views:

      '.sign-in': ->
        new SignIn

      '.sign-up': ->
        new SignUp