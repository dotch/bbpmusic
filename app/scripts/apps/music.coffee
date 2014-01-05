@MusicProject.module "Music", (Music, App, Backbone, Marionette, $, _) ->
  
  class Music.Router extends Marionette.AppRouter
    appRoutes:
      "intro" : "intro"
      "rating" : "rating"
  
  API =
    intro: ->
      new Music.Intro.Controller
    rating: ->
      new Music.Rating.Controller

  App.commands.setHandler "switch:to:rating", ->
    App.navigate "rating"
    API.rating()

  App.addInitializer ->
    new Music.Router
      controller: API
  