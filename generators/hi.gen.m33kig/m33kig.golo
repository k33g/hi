module m33kig

function generator = |hi| { #hi m33kig
  #require(hi: arguments(): size() == 3, "use it like that : hi bb:m:Human")

    println("=== m33ki golo webapp generator ===")

    if hi: arguments(): size() == 1 { # main application
      # create structure
      hi: makeDirectory("public/js/models")
      hi: makeDirectory("public/js/components")
      hi: makeDirectory("public/js/modules")

      let applicationName = readln("Application name? ")
      # Application infos
      let infos = DynamicObject()
        : applicationName("applicationName")
        : version("0.0.0")
        : description("generated thanks to hi and golo")
        : name("k33g0rg")

      let bower_json = hi: template(hi: loadTemplate("bower"), "infos", infos)
      let index_html = hi: template(hi: loadTemplate("index"), "infos", infos)

      hi: copyToFile(index_html,"public/index.html")
      hi: copyToFile(bower_json,"bower.json")

      hi: copyToFile(hi: loadFile(".bowerrc"), ".bowerrc")
      hi: copyToFile(hi: loadFile("all.scripts.js"), "public/js/all.scripts.js")

      hi: copyToFile(hi: loadFile("main.js"), "public/js/main.js")
      hi: copyToFile(hi: loadFile("BigTitle.js"), "public/js/components/BigTitle.js")

      println("Single Page Application structure is generated")
      println("Running 'bower update'")

      println("OS : " + hi: os())

      if hi: isWindows() is true { # trick
        hi: copyToFile(hi: loadFile("run-bower.bat"), "run-bower.bat")
        hi: runCmd("run-bower.bat", 0)
      } else { # osx or tux
        hi: bowerUpdate()
      }

    } else { # sub-generators
      let infos = DynamicObject()

      # === Generate Backbone Model and Collection
      if hi: arguments(): get(1): equals("bbmc") { #hi m33kig:bbmc:Human
        #let modelName = readln("Model name? ")
        let modelName = hi: arguments(): get(2)
        let defaults = readln("Default values (ie: first:'',last'')? ")
        infos: modelName(modelName)
        infos: defaults(defaults)

        let model_js = hi: template(hi: loadTemplate("model"), "infos", infos)
        let collection_js = hi: template(hi: loadTemplate("collection"), "infos", infos)
        hi: copyToFile(model_js,"public/js/models/"+infos: modelName()+"Model.js")
        hi: copyToFile(collection_js,"public/js/models/"+infos: modelName()+"sCollection.js")

        #update all.scripts.js

        infos: models(hi: listFiles("public/js/models", false))
        infos: components(hi: listFiles("public/js/components", false))
        infos: modules(hi: listFiles("public/js/modules", false))

        let all_scripts_js = hi: template(hi: loadTemplate("all.scripts"), "infos", infos)
        hi: copyToFile(all_scripts_js,"public/js/all.scripts.js")

        println("Model and Collection have been generated.")

      }


      # === Generate MongoDB Model and Collection + Controller + Routes
      if hi: arguments(): get(1): equals("mgmc") { # hi m33kig:mgmc:Human

        #let modelName = hi: arguments(): get(2)
        #let dataBaseName = readln("Database name? ")
        #let collectionName = readln("Collection Name? ")

        infos
          : modelName(hi: arguments(): get(2))
          : dataBaseName(readln("MongoDb Database name? "))
          : collectionName(readln("MongoDb Collection Name? "))

        # --- Model & Collection ---
        let mongo_model = hi: template(hi: loadTemplate("mgmodel"), "infos", infos)
        hi: copyToFile(mongo_model,"app/models/"+infos: modelName()+".golo")

        # --- Controller ---
        let mongo_controller = hi: template(hi: loadTemplate("mgcontroller"), "infos", infos)
        hi: copyToFile(mongo_controller,"app/controllers/"+infos: modelName()+"s.golo")

        # --- Routes ---
        let mongo_routes = hi: template(hi: loadTemplate("routes"), "infos", infos)
        hi: copyToFile(mongo_routes,"app/routes/"+infos: modelName()+"s.routes.golo")

        #println(hi: listFiles("app/routes/", false))

        infos: imports(list[])
        infos: routes(list[])

        hi: listFiles("app/routes/", false): each(|file| {
          if file: getName(): equals("routes.golo") isnt true {
            #println(file: getName())

            infos: imports(): append("routes." + file: getName(): split(".routes.golo"): get(0): toLowerCase())

            infos: routes(): append(
              "define" + file: getName(): split(".routes.golo"): get(0) + "Routes()"
             )
          }

        })

        #println(infos: imports())
        #println(infos: routes())

        let all_routes = hi: template(hi: loadTemplate("all.routes"), "infos", infos)
        hi: copyToFile(all_routes,"app/routes/routes.golo")

        println("MongoDb Model, Collection, Routes and Controller have been generated.")

      }

      # === Table ===
      if hi: arguments(): get(1): equals("rt") { # hi m33kig:rt:HumansTable:Human
        let componentName = hi: arguments(): get(2)
        let modelName = hi: arguments(): get(3)

        let allFields = readln("Fields (ie: firstName, lastName)? ")
        let fields = list[]

        foreach field in allFields: split(",") {
          fields: append(field: trim())
        }

        infos
          : componentName(componentName)
          : modelName(modelName)
          : url(modelName: toLowerCase())
          : fields(fields)

        let table_component = hi: template(hi: loadTemplate("reacttable"), "infos", infos)
        hi: copyToFile(table_component,"public/js/components/"+componentName+".js")

        #update all.scripts.js

        infos: models(hi: listFiles("public/js/models", false))
        infos: components(hi: listFiles("public/js/components", false))
        infos: modules(hi: listFiles("public/js/modules", false))

        let all_scripts_js = hi: template(hi: loadTemplate("all.scripts"), "infos", infos)
        hi: copyToFile(all_scripts_js,"public/js/all.scripts.js")

        println("Table has been generated.")

      }

      # === Form ===
      if hi: arguments(): get(1): equals("rf") { # hi m33kig:rf:HumanForm:Human
        let componentName = hi: arguments(): get(2)
        let modelName = hi: arguments(): get(3)

        let allFields = readln("Fields (ie: firstName, lastName)? ")
        let fields = list[]

        foreach field in allFields: split(",") {
          fields: append(field: trim())
        }

        infos
          : componentName(componentName)
          : modelName(modelName)
          : url(modelName: toLowerCase())
          : fields(fields)

        let form_component = hi: template(hi: loadTemplate("reactform"), "infos", infos)
        hi: copyToFile(form_component,"public/js/components/"+componentName+".js")

        #update all.scripts.js

        infos: models(hi: listFiles("public/js/models", false))
        infos: components(hi: listFiles("public/js/components", false))
        infos: modules(hi: listFiles("public/js/modules", false))

        let all_scripts_js = hi: template(hi: loadTemplate("all.scripts"), "infos", infos)
        hi: copyToFile(all_scripts_js,"public/js/all.scripts.js")

        println("Form has been generated.")

      }

      if hi: arguments(): get(1): equals("v") {
        println("wip")
      } else {

      }
    }

}

