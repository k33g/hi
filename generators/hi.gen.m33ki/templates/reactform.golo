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
			<form role="form" className="form-horizontal" onSubmit={this.handleSubmit}>
				<% infos: fields(): each(|field| { %><div className="form-group">
						<input className="form-control" type="text" placeholder="<%= field %>" ref="<%= field %>"/>
				</div>
				<% }) %>
				<div className="form-group">
					<input className="btn btn-primary" type="submit" value="Add <%= infos: modelName() %>" />
				</div>
				<div className="form-group"><strong>{this.state.message}</strong></div>
			</form>
		);
	},

	componentDidMount: function() {},
	componentWillMount: function() {},
	handleSubmit : function() {
		<% infos: fields(): each(|field| { %>var <%= field %> = this.refs.<%= field %>.getDOMNode().value.trim();
		<% }) %>
		<% infos: fields(): each(|field| { %>if (!<%= field %>) {return false;}
		<% }) %>
		var data = {};
		<% infos: fields(): each(|field| { %>data.<%= field %> = <%= field %>;
		<% }) %>

		var <%= infos: modelName(): toLowerCase() %> = new <%= infos: modelName() %>Model(data);

		<%= infos: modelName(): toLowerCase() %>.save()
			.done(function(data) {
				this.setState({
					message : <%= infos: modelName(): toLowerCase() %>.get("_id") + " added!"
				});
				<% infos: fields(): each(|field| { %>this.refs.<%= field %>.getDOMNode().value = '';
				<% }) %>
				this.refs.<%= infos: fields(): getFirst() %>.getDOMNode().focus();
			}.bind(this))
			.fail(function(err) {
				this.setState({
					message  : err.responseText + " " + err.statusText
				});
			}.bind(this));

		return false;
	}

});
