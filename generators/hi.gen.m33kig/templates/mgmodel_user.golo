module models.<%= infos: modelName(): toLowerCase() %>

import m33ki.mongodb2
import m33ki.authentication

# Model
function <%= infos: modelName() %> = {
  let model = MongoModel(
    Mongo()
      : database("<%= infos: dataBaseName() %>")
      : collection("<%= infos: collectionName() %>")
  )

  model: mixin(UserWithRights("HelloWorld")) # "HelloWorld" is the security key
  return model
}

# Collection
function <%= infos: modelName() %>s = -> MongoCollection(<%= infos: modelName() %>())

