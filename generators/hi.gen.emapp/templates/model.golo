/*=== <%= infos: modelName() %> Model ===*/

var mongoose = require('mongoose');

var <%= infos: modelName() %>Model = function() {

	var <%= infos: modelName() %>Schema = mongoose.Schema({
		<%= infos: schema() %>
	});

	return mongoose.model('<%= infos: modelName() %>', <%= infos: modelName() %>Schema);
}

module.exports = <%= infos: modelName() %>Model;

