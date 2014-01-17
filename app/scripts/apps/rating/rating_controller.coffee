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

      @listenTo @layout, "next:button:clicked", ->
        @createTasteProfile()

      @listenTo @layout, "show", =>
        @tracksRegion @ratingTracks
        @playerRegion()

      @show @layout

    createTasteProfile: ->
      data = @extractData()
      params = {}
      params["format"] = "json"
      params["id"] = "CAEHQHX14363283D8A"
      params["api_key"] = "JP8UILVPRI3CASIJ4"
      params["data"] = JSON.stringify(data)
      $.ajax(
        url: "http://developer.echonest.com/api/v4/tasteprofile/update"
        type: "POST"
        crossDomain: true
        contentType: 'application/x-www-form-urlencoded'
        dataType: "json"
        data: params
      )
      $.get "http://developer.echonest.com/api/v4/playlist/static?api_key=JP8UILVPRI3CASIJ4&seed_catalog=CAEHQHX14363283D8A&format=json&results=5&type=song-radio&limit=true&bucket=id:deezer&bucket=tracks", (data) ->
        songs = data.response.songs
        for song in songs
          console.log "#{song.artist_name} - #{song.title}"
    extractData: ->
      items = @ratingTracks.map (model) ->
        item = {}
        item["action"] = "update"
        innerItem = {}
        innerItem["song_id"] = model.get("echonest_id")
        innerItem["rating"] = model.get("rating") * 2
        item["item"] = innerItem
        item
      items
