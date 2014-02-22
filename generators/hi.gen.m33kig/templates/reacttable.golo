/** @jsx React.DOM */

/*
	React.renderComponent(
		<<%= infos: componentName() %> pollInterval={500}/>,
		document.querySelector('<%= infos: componentName() %>')
	);
*/

var <%= infos: componentName() %> = React.createClass({

	getInitialState: function() {
		return {data : [], message : ""};
	},

	render: function() {

		var <%= infos: modelName(): toLowerCase() %>sRows = this.state.data.map(function(<%= infos: modelName(): toLowerCase() %>){
			var deleteLink = "#delete_<%= infos: modelName(): toLowerCase() %>/" + <%= infos: modelName(): toLowerCase() %>._id;

			return (
				<tr>
          <% infos: fields(): each(|field| { %><td>{<%= infos: modelName(): toLowerCase() %>.<%= field %>}</td>
          <% }) %>
					<td><a href={deleteLink}>delete{" "}{<%= infos: modelName(): toLowerCase() %>._id}</a></td>
				</tr>
			);
		});

		return (
			<div className="table-responsive">
				<strong>{this.state.message}</strong>
				<table className="table table-striped table-bordered table-hover" >
					<thead>
						<tr>
							<% infos: fields(): each(|field| { %><th><%= field %></th><% }) %>
							<th>_id</th>
						</tr>
					</thead>
					<tbody>
						{<%= infos: modelName(): toLowerCase() %>sRows}
					</tbody>
				</table>
			</div>
		);
	},

	get<%= infos: modelName() %>s : function() {

		var <%= infos: modelName(): toLowerCase() %>s = new <%= infos: modelName() %>sCollection();

		<%= infos: modelName(): toLowerCase() %>s.fetch()
			.done(function(data){
				this.setState({data : <%= infos: modelName(): toLowerCase() %>s.toJSON(), message : Date()});
			}.bind(this))
			.fail(function(err){
				this.setState({
					message  : err.responseText + " " + err.statusText
				});
			}.bind(this))
	},

	componentWillMount: function() {
		this.get<%= infos: modelName() %>s();
		setInterval(this.get<%= infos: modelName() %>s, this.props.pollInterval);
	},

	componentDidMount: function() {
		var Router = Backbone.Router.extend({
			routes : {
				"delete_<%= infos: modelName(): toLowerCase() %>/:id" : "delete<%= infos: modelName() %>"
			},
			initialize : function() {
				console.log("Initialize router of <%= infos: componentName() %> component");
			},
			delete<%= infos: modelName() %> : function(id){
				console.log("=== delete <%= infos: modelName(): toLowerCase() %> ===", id);
				new <%= infos: modelName() %>Model({_id:id}).destroy();
				this.navigate('/');
			}
		});
		this.router = new Router()
	}

});
