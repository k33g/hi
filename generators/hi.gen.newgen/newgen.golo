module newgen

function generator = |hi| {
  let generatorName = readln("Generator name ?")
  hi: create_directory_in_generators_directory(generatorName)
  hi: create_directory_in_generators_directory(generatorName+"/files")
  hi: create_directory_in_generators_directory(generatorName+"/templates")

  # generate string template
  let content = hi: template(hi: loadTemplate("README"),
    "infos",
    DynamicObject()
      : generatorName(generatorName)
  )


  hi: copy_to_file_in_generator_directory(content, generatorName+"/README.md")
  hi: copy_to_file_in_generator_directory(hi: loadFile(".gitignore"), generatorName+"/.gitignore")

}