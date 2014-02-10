module tools

import org.apache.commons.io.FileUtils
import org.apache.commons.exec.CommandLine
import org.apache.commons.exec.DefaultExecutor

augment java.lang.String {
  # interpolate
	function T = |this, dataName, data| {
		let tpl = gololang.TemplateEngine()
							:compile("<%@params "+dataName+" %> "+this)
		return tpl(data)
	}
}


function tools = |targetDir, sourceDir_current_generator, sourceDir_generators| -> DynamicObject()
  : define("hello",|this| -> println("=== HELLO HELLO HELLO ==="))
  : applicationDirectory(targetDir)
  : generators_directory(sourceDir_generators)
  : create_directory_in_generators_directory(|this, directory| {
      FileUtils.forceMkdir(java.io.File(this: generators_directory()+"/hi.gen."+directory))
  })
  : copy_to_file_in_generator_directory(|this, content, destination| {
      textToFile(content, this: generators_directory()+"/hi.gen."+destination)
  })
  : generatorDirectory(sourceDir_current_generator)
  : templatesDirectory(sourceDir_current_generator+"/templates")
  : filesDirectory(sourceDir_current_generator+"/files")
  : makeDirectory(|this, directory|{
      FileUtils.forceMkdir(java.io.File(this: applicationDirectory()+"/"+directory))
  })
  : template(|this, templateString, dataName, data|{
      return templateString: T(dataName, data)
  })
  : loadTemplate(|this, templateName| {
      return fileToText(this: templatesDirectory()+"/"+templateName+".golo", "UTF-8")
  })
  : loadFile(|this, fileName| {
      return fileToText(this: filesDirectory()+"/"+fileName, "UTF-8")
  })
  : copyToFile(|this, content, destination| {
      textToFile(content, this: applicationDirectory()+"/"+destination)
  })
  : npmInstall(|this|{
    let line = "npm install"
    let cmdLine = CommandLine.parse(line)
    let executor = DefaultExecutor()
    let exitValue = executor: execute(cmdLine)
  })
  : bowerUpdate(|this|{
    let line = "bower update"
    let cmdLine = CommandLine.parse(line)
    let executor = DefaultExecutor()
    let exitValue = executor: execute(cmdLine)
  })

