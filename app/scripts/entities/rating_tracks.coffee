@MusicProject.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->
  
  class Entities.RatingTrack extends Parse.Object
    className: "RatingTrack"

  class Entities.RatingTracks extends Parse.Collection
    model: Entities.RatingTrack
      
  API =
    getRatingTracks: ->
      ratingTracks = new Entities.RatingTracks
      query = new Parse.Query(Entities.RatingTrack)
      ratingTracks.query = query
      ratingTracks.fetch()
      ratingTracks
  
  App.reqres.setHandler "entities:rating:tracks", ->
    API.getRatingTracks()