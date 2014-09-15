/*--- <%= infos: modelName() %>s Collection ---*/

var <%= infos: modelName() %>sCollection = Backbone.Collection.extend({
	url : "<%= infos: modelName(): toLowerCase() %>s",
	model: <%= infos: modelName() %>Model
});


