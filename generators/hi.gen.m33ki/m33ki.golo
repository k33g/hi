module m33ki

augment java.lang.Object {
  function notEquals = |this, value| {
    return not this: equals(value)
  }
}

function updateJSLoader = |hi, infos| {
    infos: models(hi: listFiles("public/js/models", false))
    infos: components(hi: listFiles("public/js/components", false))
    infos: modules(hi: listFiles("public/js/modules", false))

    let all_scripts_js = hi: template(hi: loadTemplate("all.scripts"), "infos", infos)
    hi: copyToFile(all_scripts_js,"public/js/all.scripts.js")
}

function updateIndexHtml = |hi, infos| {
  infos: htmlPages(
    hi: listFiles("public", false)
      : filter(|page| -> page: getName(): endsWith(".html"))
      : filter(|page| -> not(page: getName(): endsWith("index.html")))
  )

  let all_html_pages = hi: template(hi: loadTemplate("all.html"), "infos", infos)
  hi: copyToFile(all_html_pages,"public/index.html")

}

# === Generate Backbone Model and Collection
function gen_backbone = |hi, infos| {

  let modelName = readln("Model name? ")
  let defaults = readln("Default values (ie: first:'',last'')? ")
  infos: modelName(modelName)
  infos: defaults(defaults)

  let model_js = hi: template(hi: loadTemplate("model"), "infos", infos)
  let collection_js = hi: template(hi: loadTemplate("collection"), "infos", infos)
  hi: copyToFile(model_js,"public/js/models/"+infos: modelName()+"Model.js")
  hi: copyToFile(collection_js,"public/js/models/"+infos: modelName()+"sCollection.js")

  #update all.scripts.js
  updateJSLoader(hi, infos)

  println("Model and Collection have been generated.")
  println("")
  return null

}

# === Generate MongoDB Model and Collection + Controller + Routes
function gen_mongodb = |hi, infos| {
  infos
    : modelName(readln("Model name? "))
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

      infos: imports(): append("routes." + file: getName(): split(".routes.golo"): get(0): toLowerCase())

      infos: routes(): append(
        "define" + file: getName(): split(".routes.golo"): get(0) + "Routes()"
       )
    }

  })

  let all_routes = hi: template(hi: loadTemplate("all.routes"), "infos", infos)
  hi: copyToFile(all_routes,"app/routes/routes.golo")

  println("MongoDb Model, Collection, Routes and Controller have been generated.")
  println("")
  return null
}


function gen_react_ui_table = |hi, infos| {

  let modelName = infos: modelName()

  #let allFields = readln("Fields (ie: firstName, lastName)? ")
  #let fields = list[]

  #foreach field in allFields: split(",") {
  #  fields: append(field: trim())
  #}

  # === Table ===
  let componentName = modelName+"sTable"

  infos
    : componentName(componentName)
    : table_componentName(componentName)
    : table_tagName(modelName: toLowerCase()+"s-table")

  let table_component = hi: template(hi: loadTemplate("reacttable"), "infos", infos)
  hi: copyToFile(table_component,"public/js/components/"+componentName+".js")

  #update all.scripts.js
  updateJSLoader(hi, infos)

  println("Table has been generated.")
  return null
}

function gen_react_ui_form = |hi, infos| {
# === Form ===
  let modelName = infos: modelName()

  let componentName = modelName+"Form"

  let allFields = readln("Fields (ie: firstName, lastName)? ")
  let fields = list[]

  foreach field in allFields: split(",") {
    fields: append(field: trim())
  }

  infos
    : componentName(componentName)
    : form_componentName(componentName)
    : form_tagName(modelName: toLowerCase()+"-form")
    : url(modelName: toLowerCase())
    : fields(fields)

  let form_component = hi: template(hi: loadTemplate("reactform"), "infos", infos)
  hi: copyToFile(form_component,"public/js/components/"+componentName+".js")

  #update all.scripts.js
  updateJSLoader(hi, infos)

  println("Form has been generated.")
  return null

}

function gen_react_main = |hi, infos| {
  let modelName = infos: modelName()
  let main_load_components = hi: template(hi: loadTemplate("react_index"), "infos", infos)
  hi: copyToFile(main_load_components,"public/index."+modelName: toLowerCase()+"s.html")

  #update all.scripts.js
  updateJSLoader(hi, infos)

  println("index."+modelName: toLowerCase()+".html has been generated.")

  updateIndexHtml(hi, infos)
  println("index.html has been generated.")

  println("")
  return null
}

function gen_react_ui = |hi, infos| {
  infos: modelName(readln("Model name? "))
  gen_react_ui_form(hi, infos)
  gen_react_ui_table(hi, infos)
  gen_react_main(hi, infos)

}

function gen_react_shell = |hi, infos| {
  let componentName = readln("Component name? ")
  let tag = readln("Tag name container? ")

  infos
    : componentName(componentName)
    : tag(tag)

  let react_component = hi: template(hi: loadTemplate("reactshell"), "infos", infos)
  hi: copyToFile(react_component,"public/js/components/"+componentName+".js")

  #update all.scripts.js
  updateJSLoader(hi, infos)

  println("Component has been generated.")
  println("")
  return null

}

local function choice_menu = |hi| {

    let infos = DynamicObject()

    println("=== m33ki golo webapp generator ===")

    println("")
    println("1- MongoDB Model and Collection + Controller + Routes")
    println("2- Backbone Model and Collection")
    println("3- React UI")
    println("4- React empty component")
    println("x- Exit")

    println("")

    let choice = readln("choice?>")

    #=== run it

    case {
      when choice: equals("1") {
        gen_mongodb(hi, infos)
      }
      when choice: equals("2") {
        gen_backbone(hi, infos)
      }
      when choice: equals("3") {
        gen_react_ui(hi, infos)
      }
      when choice: equals("4") {
        gen_react_shell(hi, infos)
      }
      otherwise {
        println("")
      }
    }


    return choice
}


function generator = |hi| { #hi m33ki

    while choice_menu(hi): notEquals("x") {}

    if hi: arguments(): size() == 1 { # main application

    } else { # sub-generators
      let infos = DynamicObject()

      # === Shell ===
      if hi: arguments(): get(1): equals("rshell") { # hi m33kig:rshell:MyComponent:div
        let componentName = hi: arguments(): get(2)
        let tag = hi: arguments(): get(3)

        infos
          : componentName(componentName)
          : tag(tag)

        let react_component = hi: template(hi: loadTemplate("reactshell"), "infos", infos)
        hi: copyToFile(react_component,"public/js/components/"+componentName+".js")

        #update all.scripts.js
        updateJSLoader(hi, infos)

        println("Component has been generated.")

      }


      if hi: arguments(): get(1): equals("v") {
        println("wip")
      } else {

      }
    }

}

