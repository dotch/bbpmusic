@MusicProject.module "Music.Rating", (Rating, App, Backbone, Marionette, $, _) ->
  
  class Rating.Controller extends App.Controllers.Base
    
    initialize: ->
      @ratingTracks = App.request "entities:rating:tracks"
      @listenTo @ratingTracks, "reset", =>
        @setupViews()

    tracksRegion: (tracks) ->
      tracksView = new Rating.TracksView
        collection: tracks
      @layout.tracksRegion.show tracksView
      @listenTo tracksView, "childview:track:rated", (child, args) ->
        child.model.set('rating', args.rating)
      @listenTo tracksView, "childview:play:button:clicked", (child, args) ->
        console.log "play button clicked"
        App.execute "play:song", child.model
      @listenTo tracksView, "childview:pause:button:clicked", ->
        console.log "pause button clicked"
        App.execute "pause:song"

    playerRegion: ->
      playerView = App.request "music:player"
      @layout.playerRegion.show playerView

    setupViews: ->
      @layout = new Rating.Layout

      @listenTo @layout, "show", =>
        @tracksRegion @ratingTracks
        @playerRegion()

      @show @layout