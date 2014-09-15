var AllRoutes = function(app) {
  <% infos: routes(): each(|file| { %>
  require('./routes/<%= file: getName(): split(".js"): get(0) %>')(app);<% }) %>
}
module.exports = AllRoutes;
