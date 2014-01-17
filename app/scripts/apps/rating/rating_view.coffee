@MusicProject.module "Music.Rating", (Rating, App, Backbone, Marionette, $, _) ->
  
  class Rating.Layout extends App.Views.Layout
    template: "rating/layout"
    
    regions:
      tracksRegion:  "#tracks-region"
      playerRegion:  "#player-region"

    triggers:
      "click #next": "next:button:clicked"

  class Rating.TrackView extends App.Views.ItemView
    initialize: ->
      unless @model.has("rating")
        @model.set("rating", 0)
      unless @model.has("isPlaying")
        @model.set("isPlaying", false)
    template: "rating/_rating_track"
    ui:
      control: "#control"
      stars: ".star"
    modelEvents:
      "change": "render"
    events:
      "mouseenter .star": "mouseEnterRating"
      "mouseout .star": "mouseOutRating"
      "click .star": "clickedRating"
    triggers:
      "click .play": "play:button:clicked"
      "click .pause": "pause:button:clicked"
      "dblclick": "play:button:clicked"
    mouseEnterRating: (e) ->
      @setStars $(e.currentTarget).data("value")
    mouseOutRating: (e) ->
      @setStars @model.get("rating")
    setStars: (count) ->
      for i in [0...count]
        @setStar(i)
      for i in [count...5]
        @unsetStar(i)
    unsetStar: (i) ->
      $(@ui.stars[i]).removeClass("glyphicon-star").addClass("glyphicon-star-empty")
    setStar: (i) ->
      $(@ui.stars[i]).removeClass("glyphicon-star-empty").addClass("glyphicon-star")
    clickedRating: (e) ->
      $target = $(e.currentTarget)
      value = $target.data("value")
      @trigger "track:rated",{rating: value}
      e.preventDefault()
      e.stopPropagation()



  class Rating.TracksView extends App.Views.CompositeView
    template: "rating/_rating_tracks"
    itemView: Rating.TrackView
    itemViewContainer: "#tracks"