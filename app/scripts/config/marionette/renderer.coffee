do (Marionette) ->
  _.extend Marionette.Renderer,

    lookup: "app/scripts/templates/"
      
    render: (template, data) -> 
      if !template then return
      path = @lookup + template + ".ejs"
      if !JST[path]
        throw "Template " + template + " not found!"
      JST[path](data)

