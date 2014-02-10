/*=== Hello Routes ===*/

var HelloRoutes = function(app) {

  app.get("/hello", function(req, res) {
    res.send("<h1>HELLO</h1>");
  });

}

module.exports = HelloRoutes;