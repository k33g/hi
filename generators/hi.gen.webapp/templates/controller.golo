/*=== <%= infos: modelName() %> Controller ===*/

var <%= infos: modelName() %> = require("../models/<%= infos: modelName() %>")();

var <%= infos: modelName() %>sCtrl = {
	create : function(req, res) {
		var <%= infos: modelName(): toLowerCase() %> = new <%= infos: modelName() %>(req.body)
			<%= infos: modelName(): toLowerCase() %>.save(function (err, <%= infos: modelName(): toLowerCase() %>) {
			res.send(<%= infos: modelName(): toLowerCase() %>);
		});
	},
	fetchAll : function(req, res) {
		<%= infos: modelName() %>.find(function (err, <%= infos: modelName(): toLowerCase() %>s) {
			res.send(<%= infos: modelName(): toLowerCase() %>s);
		});
	},
	fetch : function(req, res) {
		<%= infos: modelName() %>.find({_id:req.params.id}, function (err, <%= infos: modelName(): toLowerCase() %>s) {
			res.send(<%= infos: modelName(): toLowerCase() %>s[0]);
		});
	},
	update : function(req, res) {
		delete req.body._id
		<%= infos: modelName() %>.update({_id:req.params.id}, req.body, function (err, <%= infos: modelName(): toLowerCase() %>) {
			res.send(<%= infos: modelName(): toLowerCase() %>);
		});
	},
	delete : function(req, res) {
		<%= infos: modelName() %>.findOneAndRemove({_id:req.params.id}, function (err, <%= infos: modelName(): toLowerCase() %>) {
			res.send(<%= infos: modelName(): toLowerCase() %>);
		});
	}
}

module.exports = <%= infos: modelName() %>sCtrl;
