/*=== <%= infos: applicationName() %> Application ===*/
var args = process.argv.splice(2);
var express = require('express')
  , bodyParser = require('body-parser');

var app = express()

app.use(express.static(__dirname + '/public'));
app.use(bodyParser.json());

require("./db/db").once('open', function callback () {
	/*=== insert routes here ===*/
	require("./all.routes")(app);
});

app.listen(args[0] || 3000);
console.log("Listening on 3000")

/* the end */