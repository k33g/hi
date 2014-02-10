{
  "name": "<%= infos: applicationName() %>",
  "description" : "<%= infos: description() %>",
  "version": "<%= infos: version() %>",
  "repository" : {
    "type" : "git",
    "url" : "<%= infos: gitRepository() %>"
  },
  "license" : "MIT",
  "author" : {
    "name" : "<%= infos: name() %>",
    "twitter" : "<%= infos: twitter() %>",
    "url" : "<%= infos: www() %>"
  },

  "dependencies": {
    "express": "x.x",
    "mongoose": "x.x"
  }
}