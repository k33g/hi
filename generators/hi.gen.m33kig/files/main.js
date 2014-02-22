/** @jsx React.DOM */

Backbone.history.start();

var messageTitle = "Hello World from M33ki";
var version  = 42;

React.renderComponent(
  <BigTitle message={messageTitle} version={version}/>,
  document.querySelector('big-title')
);
