module controllers.<%= infos: modelName(): toLowerCase() %>s

import m33ki.spark
import m33ki.jackson
import models.<%= infos: modelName(): toLowerCase() %>

struct <%= infos: modelName(): toLowerCase() %>sController = {
  <%= infos: modelName(): toLowerCase() %>s
}

augment <%= infos: modelName(): toLowerCase() %>sController {
  function getAll = |this, request, response| {
    # GET request : get all models
    response
      : json(Json(): toJsonString(this: <%= infos: modelName(): toLowerCase() %>s(): fetch()))
      : status(200)
  }
  function getOne = |this, request, response| {
    # GET request : get one model by id
    let id = request: params(":id")
    let <%= infos: modelName(): toLowerCase() %> = this: <%= infos: modelName(): toLowerCase() %>s(): model(): fetch(id)

    if <%= infos: modelName(): toLowerCase() %> isnt null{
      response: json(<%= infos: modelName(): toLowerCase() %>: toJsonString()): status(200)
    } else {
      response: json(Json(): toJsonString(map[["message", <%= infos: modelName(): toLowerCase() %> + " not found"]])): status(404) # 404 Not found
    }
  }
  function create = |this, request, response| {
    # POST request : create a model
    let <%= infos: modelName(): toLowerCase() %> = this: <%= infos: modelName(): toLowerCase() %>s(): model(): fromJsonString(request: body())
    <%= infos: modelName(): toLowerCase() %>: insert() # insert in collection
    response: json(<%= infos: modelName(): toLowerCase() %>: toJsonString()): status(201) # 201: created
  }
  function update = |this, request, response| {
    # PUT request : update a model
    let <%= infos: modelName(): toLowerCase() %> = this: <%= infos: modelName(): toLowerCase() %>s(): model(): fromJsonString(request: body())
    <%= infos: modelName(): toLowerCase() %>: update() # update in collection
    response: json(<%= infos: modelName(): toLowerCase() %>: toJsonString()): status(200) # 200: Ok + return data
  }
  function delete = |this, request, response| {
    # DELETE request : delete a model
    let id = request: params(":id")
    let <%= infos: modelName(): toLowerCase() %> = this: <%= infos: modelName(): toLowerCase() %>s(): model(): remove(id)
    response: json(<%= infos: modelName(): toLowerCase() %>: toJsonString()): status(200) # 200: Ok + return data
  }
}

function <%= infos: modelName() %>sController = |<%= infos: modelName(): toLowerCase() %>s| { #<%= infos: modelName(): toLowerCase() %>s is a collection
  return <%= infos: modelName(): toLowerCase() %>sController(<%= infos: modelName(): toLowerCase() %>s)
  #W.I.P.
}

