/*=== <%= infos: modelName() %> CRUD Routes ===*/
var <%= infos: modelName() %>sCtrl = require("../controllers/<%= infos: modelName() %>sCtrl");

var <%= infos: modelName() %>sRoutes = function(app) {

	app.post("/<%= infos: url() %>", function(req, res) {
		<%= infos: modelName() %>sCtrl.create(req, res);
	});

	app.get("/<%= infos: url() %>", function(req, res) {
		<%= infos: modelName() %>sCtrl.fetchAll(req, res);
	});

	app.get("/<%= infos: url() %>/:id", function(req, res) {
		<%= infos: modelName() %>sCtrl.fetch(req, res);
	});

	app.put("/<%= infos: url() %>/:id", function(req, res) {
		<%= infos: modelName() %>sCtrl.update(req, res);
	});

	app.delete("/<%= infos: url() %>/:id", function(req, res) {
		<%= infos: modelName() %>sCtrl.delete(req, res);
	});

}

module.exports = <%= infos: modelName() %>sRoutes;