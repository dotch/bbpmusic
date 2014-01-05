@MusicProject.module "Music.Intro", (Intro, App, Backbone, Marionette, $, _) ->
  
  class Intro.View extends App.Views.ItemView
    template: "intro/view",
    triggers:
      "click #button-next": "next:button:clicked" 
    