module hi

import java.io.File
import java.io.IOException

import com.fasterxml.jackson.core.JsonProcessingException
import com.fasterxml.jackson.databind.JsonNode
import com.fasterxml.jackson.databind.ObjectMapper
import com.fasterxml.jackson.databind.node.ObjectNode

import tools
----
#hi (Generator)

----
function main = |args| {
  require(args: size(): equals(3), "Three arguments needed!")

  let OS = java.lang.System.getProperty("os.name"): toLowerCase()
  let isWindows = -> OS: indexOf("win") >= 0
  let isMac = -> OS: indexOf("mac") >= 0
  let isLinux = -> (OS: indexOf("nix") >= 0) or (OS: indexOf("nux") >= 0)

  println("""
.__    .__                       ._.
|  |__ |__|   _____ _____    ____| |
|  |  \|  |  /     \\__  \  /    \ |
|   Y  \  | |  Y Y  \/ __ \|   |  \|
|___|  /__| |__|_|  (____  /___|  /_
     \/           \/     \/     \/\/
HI Generator (c) 2014-2015 @k33g_org
""")

  #println(" OS : " + OS)
  #println("isWindows : " + isWindows() + " isMac : " + isMac() + " isLinux : " + isLinux())

  let sourceDir = args: get(0)
  let targetDir = args: get(1)

  let args_generator = args: get(2): split(":")

  let generatorName = args_generator: get(0)

  let sourceDir_generators = sourceDir + "/generators"
  let srcDir_generators = File(sourceDir_generators)


  try {

    ### Load and execute generator

    let env = gololang.EvaluationEnvironment()
    let generator_module = env:asModule(fileToText(sourceDir_generators+"/hi.gen."+generatorName+"/"+generatorName+".golo", "UTF-8"))
    let generator = fun("generator", generator_module)

    generator(tools(
      targetDir,
      sourceDir_generators+"/hi.gen."+generatorName, sourceDir_generators,
      args_generator)
    )

    ### end of generator execution

  } catch(e) {
    e: printStackTrace()
  }

}

