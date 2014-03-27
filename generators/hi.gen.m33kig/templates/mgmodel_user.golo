module models.<%= infos: modelName(): toLowerCase() %>

import m33ki.mongodb
import m33ki.authentication

# Collection
function <%= infos: modelName() %>s = {
  let collection = Mongo()
    : database("<%= infos: dataBaseName() %>")
    : collection("<%= infos: collectionName() %>")
  # Model
  let <%= infos: modelName() %> = |collection| {
    let model = MongoModel(collection)
    model: mixin(UserWithRights("HelloWorld")) # "HelloWorld" is the security key
    return model
  }

  return MongoCollection(<%= infos: modelName() %>, collection)
}
