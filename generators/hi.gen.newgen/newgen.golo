module newgen

function generator = |hi| {
  let generatorName = readln("Generator name ?")
  hi: create_directory_in_generators_directory(generatorName)
  hi: create_directory_in_generators_directory(generatorName+"/files")
  hi: create_directory_in_generators_directory(generatorName+"/templates")

  let infos = DynamicObject(): generatorName(generatorName:trim())

  # generate string template
  let content = hi: template(
    hi: loadTemplate("README"),
    "infos", infos
  )

  let main = hi: template(
    hi: loadTemplate("main"),
    "infos", infos
  )

  hi: copy_to_file_in_generator_directory(content, generatorName+"/README.md")
  hi: copy_to_file_in_generator_directory(main, generatorName+"/"+generatorName+".golo")
  hi: copy_to_file_in_generator_directory(hi: loadFile(".gitignore"), generatorName+"/.gitignore")

}