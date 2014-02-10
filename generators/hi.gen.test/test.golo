#Test Generator
module test

function generator = |hi| {

  println("=== Test Generator ===")
  println("applicationDirectory : "+hi: applicationDirectory())
  println("generatorDirectory : "+hi: generatorDirectory())

  hi: makeDirectory("public/js/models")

  # generate string template
  var myModel = hi: template(hi: loadTemplate("bb"),
    "infos",
    DynamicObject()
      : model_name("Human")
      : fields(["firstName:''", "lastName:''"])
  )

  hi: copyToFile(myModel,"public/js/models/HumanModel.js")

  println("Human Backbone model has been generated ;)")
}