module models.<%= infos: modelName(): toLowerCase() %>

import m33ki.mongodb

# Collection
function <%= infos: modelName() %>s = {
  let collection = Mongo()
    : database("<%= infos: dataBaseName() %>")
    : collection("<%= infos: collectionName() %>")
  # Model
  let <%= infos: modelName() %> = |collection| -> MongoModel(collection)

  return MongoCollection(<%= infos: modelName() %>, collection)
}

