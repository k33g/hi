module webapp

function generator = |hi| {
  println("=== WEBAPP ===")

  if hi: arguments(): size() == 1 { # main application
    # create structure
    hi: makeDirectory("public/js")
    hi: makeDirectory("routes")
    hi: makeDirectory("db")

    # bb
    hi: makeDirectory("public/js/models")
    hi: makeDirectory("public/js/routers")
    hi: makeDirectory("public/js/views")
    # bb

    # Application informations
    let infos = DynamicObject()
      : applicationName("MyBigApplication")
      : dataBaseName("mydatabase")
      : description("This is my application")
      : version("0.0.0")
      : gitRepository("https://github.com/you/yourapp.git")
      : name("John Doe")
      : twitter("@JohnDoe")
      : www("http://www.your.site")

    # Create Express application
    let app_js = hi: template(hi: loadTemplate("app"), "infos", infos)
    let db_js = hi: template(hi: loadTemplate("db"), "infos", infos)
    let package_json = hi: template(hi: loadTemplate("package"), "infos", infos)
    let bower_json = hi: template(hi: loadTemplate("bower"), "infos", infos)

    let index_html = hi: template(hi: loadTemplate("index"), "infos", infos)

    hi: copyToFile(index_html,"public/index.html")
    hi: copyToFile(package_json,"package.json")
    hi: copyToFile(bower_json,"bower.json")
    hi: copyToFile(app_js,"app.js")
    hi: copyToFile(db_js,"db/db.js")
    hi: copyToFile(hi: loadFile("all.routes.js"), "all.routes.js")
    hi: copyToFile(hi: loadFile("Hello.routes.js"), "routes/Hello.routes.js")
    hi: copyToFile(hi: loadFile(".bowerrc"), ".bowerrc")

    hi: copyToFile(hi: loadFile("all.scripts.js"), "public/js/all.scripts.js")

    println("Generator is done")
    println("Running 'npm install' then 'bower update'")

    println("OS : " + hi: os())

    if hi: isWindows() is true { # trick
      hi: copyToFile(hi: loadFile("run-npm.bat"), "run-npm.bat")
      hi: copyToFile(hi: loadFile("run-bower.bat"), "run-bower.bat")

      hi: runCmd("run-npm.bat", 0)
      hi: runCmd("run-bower.bat", 0)

    } else { # osx or tux
      hi: npmInstall()
      hi: bowerUpdate()
    }
  } else { # sub-generators
    println("arguments : " + hi: arguments(): get(0) + " " + hi: arguments(): get(1))

      if hi: arguments(): get(1): equals("mgroutes") {
        hi: makeDirectory("models")
        hi: makeDirectory("controllers")

        let infos = DynamicObject()

        infos: modelName(readln("Model name? "))
        infos: schema(readln("Schema (ie: name:String)? "))
        infos: url(infos: modelName(): toLowerCase()+"s")
        println("url : " + infos: url())

        println("Generating %s model": format(infos: modelName()))

        let model_js = hi: template(hi: loadTemplate("model"), "infos", infos)
        hi: copyToFile(model_js,"models/"+infos: modelName()+".js")

        println("Generating %s controller": format(infos: modelName()))

        let controller_js = hi: template(hi: loadTemplate("controller"), "infos", infos)
        hi: copyToFile(controller_js,"controllers/"+infos: modelName()+"sCtrl.js")

        println("Generating %s CRUD routes": format(infos: modelName()))

        let routes_js = hi: template(hi: loadTemplate("routes"), "infos", infos)
        hi: copyToFile(routes_js,"routes/"+infos: modelName()+"s.routes.js")

        println("Generating all routes")

        infos: routes(hi: listFiles("routes", false))

        let all_routes_js = hi: template(hi: loadTemplate("all.routes"), "infos", infos)
        hi: copyToFile(all_routes_js,"all.routes.js")

        println("File generation is done")

      }

      if hi: arguments(): get(1): equals("bbmc") { # model / collection
        let infos = DynamicObject()
        let modelName = readln("Model name? ")
        #let modelName = hi: arguments(): get(2)
        let defaults = readln("Default values (ie: first:'',last:'')? ")
        infos: modelName(modelName)
        infos: defaults(defaults)

        let model_js = hi: template(hi: loadTemplate("bbmodel"), "infos", infos)
        let collection_js = hi: template(hi: loadTemplate("bbcollection"), "infos", infos)
        hi: copyToFile(model_js,"public/js/models/"+infos: modelName()+"Model.js")
        hi: copyToFile(collection_js,"public/js/models/"+infos: modelName()+"sCollection.js")

        #update all.scripts.js

        infos: models(hi: listFiles("public/js/models", false))

        infos: routers(hi: listFiles("public/js/routers", false))
        infos: views(hi: listFiles("public/js/views", false))

        let all_scripts_js = hi: template(hi: loadTemplate("all.scripts"), "infos", infos)
        hi: copyToFile(all_scripts_js,"public/js/all.scripts.js")

        println("Model and Collection have been generated.")

      }
  }

}