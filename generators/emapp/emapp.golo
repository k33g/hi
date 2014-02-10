module emapp

function generator = |hi| {
  println("=== EMAPP ===")

  # create structure
  hi: makeDirectory("public/js")
  hi: makeDirectory("routes")
  hi: makeDirectory("db")

  #TODO: ask for api

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

  println("Generator is done")
  println("Running 'npm install' ...")

  hi: npmInstall()
  hi: bowerUpdate()


}