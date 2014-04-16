/** @jsx React.DOM */

/*
	React.renderComponent(
		<<%= infos: componentName() %> pollInterval={500}/>,
		document.querySelector('<%= infos: componentName() %>')
	);
*/

var <%= infos: componentName() %> = React.createClass({

	getInitialState: function() {
		return {
		    data : []
		  , message : ""
      , selected<%= infos: modelName() %>IdForUpdate : null
      , timer : null
      <% infos: fields(): each(|field| { %>, <%= field %> : null
      <% }) %>
		};
	},
  handleChange: function(name, event) { //see http://facebook.github.io/react/docs/forms.html
    var change = {};
    change[name] = event.target.value;
    this.setState(change)
  },
	render: function() {

	  var <%= infos: modelName(): toLowerCase() %>Row = function(<%= infos: modelName(): toLowerCase() %>) {

	    if(<%= infos: modelName(): toLowerCase() %>._id == this.state.selected<%= infos: modelName() %>IdForUpdate) {

          <% infos: fields(): each(|field| { %> var <%= field %> = this.state.<%= field %>
          <% }) %>

          var cancelLink = "#cancel_update_<%= infos: modelName(): toLowerCase() %>/" + <%= infos: modelName(): toLowerCase() %>._id;
          var validateLink = "#validate_update_<%= infos: modelName(): toLowerCase() %>/" + <%= infos: modelName(): toLowerCase() %>._id;

          return (
            <tr>
              <% infos: fields(): each(|field| { %><td><input className="form-control" type="text" value={<%= field %>} ref="<%= field %>" onChange={ this.handleChange.bind(this, "<%= field %>") }/></td>
              <% }) %>
              <td><a className="btn btn-primary" href={validateLink}>validate</a></td>
              <td><a className="btn btn-primary" href={cancelLink}>cancel</a></td>
            </tr>
          );

	    }

	    if(<%= infos: modelName(): toLowerCase() %>._id != this.state.selected<%= infos: modelName() %>IdForUpdate) {
        var deleteLink = "#delete_<%= infos: modelName(): toLowerCase() %>/" + <%= infos: modelName(): toLowerCase() %>._id;
        var updateLink = "#display_update_<%= infos: modelName(): toLowerCase() %>_form/" + <%= infos: modelName(): toLowerCase() %>._id;

        return (
          <tr>
            <% infos: fields(): each(|field| { %><td>{<%= infos: modelName(): toLowerCase() %>.<%= field %>}</td>
            <% }) %>
            <td><a className="btn btn-primary" href={deleteLink}>delete</a></td>
            <td><a className="btn btn-primary" href={updateLink}>edit</a></td>
          </tr>
        );

	    }


	  }.bind(this)

		var <%= infos: modelName(): toLowerCase() %>sRows = this.state.data.map(function(<%= infos: modelName(): toLowerCase() %>){
      return <%= infos: modelName(): toLowerCase() %>Row(<%= infos: modelName(): toLowerCase() %>);
		});

		return (
			<div className="table-responsive">
				<strong>{this.state.message}</strong>
				<table className="table table-striped table-bordered table-hover" >
					<thead>
						<tr>
							<% infos: fields(): each(|field| { %><th><%= field %></th><% }) %>
							<th></th>
							<th></th>
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

  update<%= infos: modelName() %> : function(<%= infos: modelName(): toLowerCase() %>Id) {

    <% infos: fields(): each(|field| { %> var <%= field %> = this.refs.<%= field %>.getDOMNode().value.trim();
    <% }) %>

    var data = {};
    data._id = <%= infos: modelName(): toLowerCase() %>Id;

    <% infos: fields(): each(|field| { %> data.<%= field %> = <%= field %>;
    <% }) %>


    var <%= infos: modelName(): toLowerCase() %> = new <%= infos: modelName() %>Model(data);

    <%= infos: modelName(): toLowerCase() %>.save()
      .done(function(data) {
        this.setState({
          message : <%= infos: modelName(): toLowerCase() %>.get("_id") + " updates!"
        });
      }.bind(this))
      .fail(function(err) {
        this.setState({
          message  : err.responseText + " " + err.statusText
        });
      }.bind(this));
  },

	componentWillMount: function() {
		this.get<%= infos: modelName() %>s();
		this.setState({timer : setInterval(this.get<%= infos: modelName() %>s, this.props.pollInterval)});
		//setInterval(this.get<%= infos: modelName() %>s, this.props.pollInterval);
	},

	componentDidMount: function() {
		var Router = Backbone.Router.extend({
			routes : {
				"delete_<%= infos: modelName(): toLowerCase() %>/:id" : "delete<%= infos: modelName() %>",
        "display_update_<%= infos: modelName(): toLowerCase() %>_form/:id" : "displayUpdate<%= infos: modelName() %>Form",
        "cancel_update_<%= infos: modelName(): toLowerCase() %>/:id" : "hideUpdate<%= infos: modelName() %>Form",
        "validate_update_<%= infos: modelName(): toLowerCase() %>/:id" : "validateUpdate<%= infos: modelName() %>"
			},
			initialize : function() {
				console.log("Initialize router of <%= infos: componentName() %> component");
			},
			delete<%= infos: modelName() %> : function(id){
				console.log("=== delete <%= infos: modelName(): toLowerCase() %> ===", id);
				new <%= infos: modelName() %>Model({_id:id}).destroy();
				this.navigate('/');
			},
      displayUpdate<%= infos: modelName() %>Form : function(id){
        console.log("=== update <%= infos: modelName(): toLowerCase() %> form ===", id);
        this.setState({selected<%= infos: modelName() %>IdForUpdate : id})

        var <%= infos: modelName(): toLowerCase() %> = new <%= infos: modelName() %>Model({_id:id}).fetch().done(
          function(data) {
            this.setState({
                message : ""
              <% infos: fields(): each(|field| { %>, <%= field %> : data.<%= field %>
              <% }) %>
            });
          }.bind(this)
        );

        //clearInterval(this.state.timer)
      }.bind(this),
      hideUpdate<%= infos: modelName() %>Form : function(id){ // when cancel
        console.log("=== hide <%= infos: modelName(): toLowerCase() %> form ===", id);
        this.setState({selected<%= infos: modelName() %>IdForUpdate : null})
        //this.setState({timer : setInterval(this.get<%= infos: modelName() %>s, this.props.pollInterval)});
      }.bind(this),
      validateUpdate<%= infos: modelName() %> : function(id){
        console.log("=== update <%= infos: modelName(): toLowerCase() %> to server ===", id);
        this.update<%= infos: modelName() %>(this.state.selected<%= infos: modelName() %>IdForUpdate)
        this.setState({selected<%= infos: modelName() %>IdForUpdate : null})
        //this.setState({timer : setInterval(this.get<%= infos: modelName() %>s, this.props.pollInterval)});
      }.bind(this)
		});
		this.router = new Router()
	}

});
