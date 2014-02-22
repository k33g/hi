function getScripts(){ return [
  <% if infos: models(): size()>0 { infos: models(): each(|file| { %>
  "js/models/<%= file: getName()%>",<% })} %>
  <% if infos: modules(): size()>0 { infos: modules(): each(|file| { %>
  "js/modules/<%= file: getName()%>",<% })} %>
  <% if infos: components(): size()>0 { infos: components(): each(|file| { %>
  "js/components/<%= file: getName()%>",<% })} %>
  "js/main.js"
];};

getScripts().forEach(function(s){
	var script = document.createElement('script');
	script.src = s;
	script.type = "text/jsx";
	document.querySelector('head').appendChild(script);
});


