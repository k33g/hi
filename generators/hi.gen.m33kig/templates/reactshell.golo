/** @jsx React.DOM */

/*
	React.renderComponent(
		<<%= infos: componentName() %>/>,
		document.querySelector('<%= infos: componentName() %>')
	);
*/

var <%= infos: componentName() %> = React.createClass({

	getInitialState: function() {
		return {data : [], message : ""};
	},

	render: function() {
		return (
			<<%= infos: tag() %>>
			</<%= infos: tag() %>>
		);
	},

	componentDidMount: function() {},
	componentWillMount: function() {}

});
