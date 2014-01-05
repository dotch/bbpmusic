@MusicProject.module "Components.MusicPlayer", (MusicPlayer, App, Backbone, Marionette, $, _) ->

  class MusicPlayer.Controller extends App.Controllers.Base
    initialize: ->
      @view = new MusicPlayer.View
      @listenTo @view, "play:clicked", (child) =>
        @play(child.model)
      @listenTo @view, "pause:clicked", =>
        @pause()
      @listenTo @view, "volume:slider:changed", (volume) =>
        @changeVolume(volume)
        
      App.vent.on "playing:song", (args) =>
        @view.model = args.song
        @view.volume = args.volume
        @view.render()
      App.vent.on "paused:playing:song", =>
        @view.render()
      App.vent.on "stopped:playing:song", =>
        @view.model = null
        @view.render()

    pause: ->
      App.execute "pause:song"
      @view.pause()

    play: (track) ->
      App.execute "play:song", track
      @view.play()

    changeVolume: (volume) ->
      App.execute "set:volume", volume

  App.reqres.setHandler "music:player", ->
    playerController = new MusicPlayer.Controller
    playerController.view