@MusicProject = do (Backbone, Marionette) ->
  
  App = new Marionette.Application
  
  App.addRegions
    mainRegion:   "#main-region"
  
  App.rootRoute = "intro"
  
  App.addInitializer ->
  
  App.reqres.setHandler "default:region", ->
    App.mainRegion
  
  App.on "initialize:after", ->

    # setup parse
    Parse.initialize("70ARDceBYgrNoRL6yJDgFubIPUZzpwKRbVVESwZC", "qNd9A8mBLkG4hrQ2M4URnP0MyQ7Bs72AbvTXhInb");

    #setup soudnmanager
    soundManager.setup
      # where to find flash audio SWFs, as needed
      url: "bower_components/soundmanager2/swf/"
      flashVersion: 9
      preferFlash: false
    @startHistory()
    @navigate(@rootRoute, trigger: true) unless @getCurrentRoute()

  App
