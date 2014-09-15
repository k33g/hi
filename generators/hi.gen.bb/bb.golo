module bb

function generator = |hi| {
  #require(hi: arguments(): size() == 3, "use it like that : hi bb:m:Human")

    println("=== BB ===")

    if hi: arguments(): size() == 1 { # main application
      # create structure
      hi: makeDirectory("public/js/models")
      hi: makeDirectory("public/js/routers")
      hi: makeDirectory("public/js/views")

      let applicationName = readln("Application name? ")
      # Application infos
      let infos = DynamicObject()
        : applicationName("applicationName")
        : version("0.0.0")

      let bower_json = hi: template(hi: loadTemplate("bower"), "infos", infos)
      let index_html = hi: template(hi: loadTemplate("index"), "infos", infos)

      hi: copyToFile(index_html,"public/index.html")
      hi: copyToFile(bower_json,"bower.json")

      hi: copyToFile(hi: loadFile(".bowerrc"), ".bowerrc")
      hi: copyToFile(hi: loadFile("all.scripts.js"), "public/js/all.scripts.js")


      println("Backbone application structure is generated")
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

      if hi: arguments(): get(1): equals("mc") {
        #let modelName = readln("Model name? ")
        let modelName = hi: arguments(): get(2)
        let defaults = readln("Default values (ie: first:'',last:'')? ")
        infos: modelName(modelName)
        infos: defaults(defaults)

        let model_js = hi: template(hi: loadTemplate("model"), "infos", infos)
        let collection_js = hi: template(hi: loadTemplate("collection"), "infos", infos)
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

      #if hi: arguments(): get(1): equals("c") {}

      if hi: arguments(): get(1): equals("r") {
        println("wip")
      }

      if hi: arguments(): get(1): equals("v") {
        println("wip")
      }
    }

}


