@MusicProject.module "Music.Intro", (Intro, App, Backbone, Marionette, $, _) ->
  
  class Intro.Controller extends App.Controllers.Base
    
    initialize: ->
      @view = new Intro.View 
      @show @view
      @listenTo @view, "next:button:clicked", (child, args) ->
        App.execute "switch:to:rating"
