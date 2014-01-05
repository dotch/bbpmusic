@MusicProject.module "Components.MusicPlayer", (MusicPlayer, App, Backbone, Marionette, $, _) ->

  class MusicPlayer.View extends App.Views.ItemView
    initialize: ->
      @volume = 100
    getTemplate: ->
      if @model
        "music_player/view"
      else
        "music_player/idle_view"      
    triggers:
      "click .play": "play:clicked"
      "click .pause": "pause:clicked"
    ui:
      "playPauseButton": "#play-pause"
      "playPauseIcon": "#play-pause glyphicon"
      "volumeIcon": ".volume span"
    events:
      "change #volume": "volumeSliderChanged"

    serializeData: ->
      if @model
        data = @model.toJSON()
        data['volume'] = @volume
      console.log data
      return data;

    volumeSliderChanged: (e) ->
      vol = parseInt($(e.currentTarget).val())
      @trigger "volume:slider:changed", vol
      @setVolumeIcon(vol)

    setVolumeIcon: (vol) ->
      @ui.volumeIcon.removeClass()
      console.log "comp", vol is 0
      if not vol
        @ui.volumeIcon.addClass("glyphicon glyphicon-volume-off")
      else if vol < 50
        @ui.volumeIcon.addClass("glyphicon glyphicon-volume-down")
      else
        @ui.volumeIcon.addClass("glyphicon glyphicon-volume-up")
    
    pause: ->
      @ui.playPauseButton.removeClass("pause").addClass("play")
      @ui.playPauseIcon.removeClass("glyphicon-pause").addClass("glyphicon-play")

    play: ->
      @ui.playPauseButton.removeClass("play").addClass("pause")
      @ui.playPauseIcon.removeClass("glyphicon-play").addClass("glyphicon-pause")