module routes
<% infos: imports(): each(|importRoute| { %>
import <%= importRoute %><% }) %>

function loadRoutes = {
<% infos: routes(): each(|defineRouteFn| { %>
    <%= defineRouteFn %> <% }) %>
}




