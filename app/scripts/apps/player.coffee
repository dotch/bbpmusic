@MusicProject.module "Music", (Music, App, Backbone, Marionette, $, _) ->

  class Music.Player

    constructor: ->
      @currentSong = null
      @number_of_plays = 0
      @volume = 100
      @played_ids = []

    playExternal: (song) ->
      if song is @currentSong and not @currentSong.get('isPlaying')
        @externalSound.play()
      else
        @stopExternal()
        @currentSong = song
        @externalSound = soundManager.createSound(
          id: "external"
          volume: @volume
          url: song.get("preview")
          autoLoad: true
          autoPlay: true
          onfinish: => 
            @stopExternal()
        )
        @played_ids.push(song.get('rank'))
        @number_of_plays++
      @currentSong.set('isPlaying',true)
      App.vent.trigger("playing:song", {'song': song, 'volume': @volume})
      
    pauseExternal: ->
      @externalSound.pause()
      @currentSong.set('isPlaying',false)
      App.vent.trigger("paused:playing:song")

    stopExternal: ->
      App.vent.trigger("stopped:playing:song")
      if @externalSound? 
        @externalSound.destruct()
        @externalSound = null
      if @currentSong?
        @currentSong.set('isPlaying',false)
        @currentSong = null

    setVolume: (volume) ->
      console.log "setting volume", volume
      @volume = volume
      soundManager.setVolume("external",volume);


  App.addInitializer ->
    Music.player = new Music.Player

  App.commands.setHandler "play:song", (track) =>
    Music.player.playExternal track
  App.commands.setHandler "pause:song", =>
    Music.player.pauseExternal()
  App.commands.setHandler "set:volume", (volume) =>
    Music.player.setVolume(volume) 