module controllers.<%= infos: modelName(): toLowerCase() %>s

import m33ki.spark
import m33ki.jackson
import models.<%= infos: modelName(): toLowerCase() %>

function <%= infos: modelName() %>sController = |<%= infos: modelName(): toLowerCase() %>s| { #<%= infos: modelName(): toLowerCase() %>s is a collection

  return DynamicObject()
    : define("getAll", |this, request, response| {
      # GET request : get all models
        response: type("application/json")
        response: status(200)
        return Json(): toJsonString(<%= infos: modelName(): toLowerCase() %>s: fetch())
    })
    : define("getOne", |this, request, response| {
      # GET request : get one model by id
        response: type("application/json")
        let id = request: params(":id")
        let <%= infos: modelName(): toLowerCase() %> = <%= infos: modelName(): toLowerCase() %>s: model(): fetch(id)

        if <%= infos: modelName(): toLowerCase() %> isnt null{
          response: status(200)
          return <%= infos: modelName(): toLowerCase() %>: toJsonString()
        } else {
          response: status(404) # 404 Not found
          return Json(): toJsonString(map[["message", "PostIt not found"]])
        }
    })
    : define("create", |this, request, response| {
      # POST request : create a model
        response: type("application/json")
        let <%= infos: modelName(): toLowerCase() %> = <%= infos: modelName(): toLowerCase() %>s: model(): fromJsonString(request: body())
        <%= infos: modelName(): toLowerCase() %>: insert() # insert in collection
        response: status(201) # 201: created
        return <%= infos: modelName(): toLowerCase() %>: toJsonString()
    })
    : define("update", |this, request, response| {
      # PUT request : update a model
        response: type("application/json")
        let <%= infos: modelName(): toLowerCase() %> = <%= infos: modelName(): toLowerCase() %>s: model(): fromJsonString(request: body())
        <%= infos: modelName(): toLowerCase() %>: update() # update in collection
        response: status(200) # 200: Ok + return data
        return <%= infos: modelName(): toLowerCase() %>: toJsonString()
    })
    : define("delete", |this, request, response| {
      # DELETE request : delete a model
        response: type("application/json")
        let id = request: params(":id")
        let <%= infos: modelName(): toLowerCase() %> = <%= infos: modelName(): toLowerCase() %>s: model(): remove(id)
        response: status(200) # 200: Ok + return data
        return <%= infos: modelName(): toLowerCase() %>: toJsonString()
    })

    #W.I.P.
}

