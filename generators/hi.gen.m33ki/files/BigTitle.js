/** @jsx React.DOM */

var BigTitle = React.createClass({

  render: function() {
    return (
      <div>
        <h1>{this.props.message}</h1>
        <h2>Version {this.props.version}</h2>
      </div>
      );
  }
});
