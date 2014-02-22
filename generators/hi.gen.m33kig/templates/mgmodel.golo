module models.<%= infos: modelName(): toLowerCase() %>

import m33ki.mongodb2

# Model
function <%= infos: modelName() %> = -> MongoModel(
  Mongo()
   : database("<%= infos: dataBaseName() %>")
   : collection("<%= infos: collectionName() %>")
)

# Collection
function <%= infos: modelName() %>s = -> MongoCollection(<%= infos: modelName() %>())

