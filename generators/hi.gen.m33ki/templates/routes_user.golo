module routes.<%= infos: modelName(): toLowerCase() %>s

import m33ki.spark
import models.<%= infos: modelName(): toLowerCase() %>
import controllers.<%= infos: modelName(): toLowerCase() %>s

import m33ki.authentication

function define<%= infos: modelName() %>sRoutes = {

  # Collection Helper
  let <%= infos: modelName(): toLowerCase() %>s = <%= infos: modelName() %>s()

  AUTHENTICATION(
      <%= infos: modelName(): toLowerCase() %>s
    , |user, authenticated| { # on LogIn
        println(user: get("pseudo") + " is authenticated : " + authenticated)
      }
    , |id, pseudo| { # on LogOut
        println(pseudo + "[" + id +  "] is gone ...")
      }
    , |id, pseudo| { # Authentication checking
        if id isnt null {
          println(pseudo +  " is online and authenticated ...")
        } else {
          println("Current user isn't authenticated ...")
        }
      }
  )

  m33ki.authentication.findOrCreateAdmin(<%= infos: modelName(): toLowerCase() %>s, "admin", "admin")


  # Create <%= infos: modelName() %>
  POST("/<%= infos: modelName(): toLowerCase() %>s", |request, response| {
    <%= infos: modelName() %>sController(<%= infos: modelName(): toLowerCase() %>s): create(request, response)
  })

  # Retrieve all <%= infos: modelName() %>s
  GET("/<%= infos: modelName(): toLowerCase() %>s", |request, response| {
    <%= infos: modelName() %>sController(<%= infos: modelName(): toLowerCase() %>s): getAll(request, response)
  })

  # Retrieve <%= infos: modelName() %> by id
  GET("/<%= infos: modelName(): toLowerCase() %>s/:id", |request, response| {
    <%= infos: modelName() %>sController(<%= infos: modelName(): toLowerCase() %>s): getOne(request, response)
  })

  # Update <%= infos: modelName() %>
  PUT("/<%= infos: modelName(): toLowerCase() %>s/:id", |request, response| {
    <%= infos: modelName() %>sController(<%= infos: modelName(): toLowerCase() %>s): update(request, response)
  })

  # delete <%= infos: modelName() %>
  DELETE("/<%= infos: modelName(): toLowerCase() %>s/:id", |request, response| {
    <%= infos: modelName() %>sController(<%= infos: modelName(): toLowerCase() %>s): delete(request, response)
  })

}
