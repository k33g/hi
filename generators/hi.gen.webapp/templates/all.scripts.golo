function getScripts(){ return [
  <% if infos: models(): size()>0 { infos: models(): each(|file| { %>
  "js/models/<%= file: getName()%>",<% })} %>
  <% if infos: routers(): size()>0 { infos: routers(): each(|file| { %>
  "js/routers/<%= file: getName()%>",<% })} %>
  <% if infos: views(): size()>0 { infos: views(): each(|file| { %>
  "js/views/<%= file: getName()%>",<% })} %>
  ""
];};

getScripts().forEach(function(s){
	var script = document.createElement('script');
	script.src = s;
	//script.type = "text/jsx";
	document.querySelector('head').appendChild(script);
})