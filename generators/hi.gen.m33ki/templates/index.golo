<!DOCTYPE html>
<html>
<head>

  <meta charset="utf-8">
  <title><%= infos: applicationName() %></title>
  <meta name="description" content="<%= infos: description() %>">
  <meta name="author" content="<%= infos: name() %>">

  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

  <link rel="stylesheet" href="js/bower_components/bootstrap/dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="js/bower_components/bootstrap/dist/css/bootstrap-theme.min.css">

</head>
<body>
  <div class="container">
    <big-title></big-title>
  </div>
  <div class="container">
    <!-- some components here -->
  </div>

  <script src="js/bower_components/jquery/dist/jquery.min.js"></script>
  <script src="js/bower_components/underscore/underscore.js"></script>
  <script src="js/bower_components/backbone/backbone.js"></script>
  <script src="js/bower_components/react/react.min.js"></script>
  <script src="js/bower_components/react/JSXTransformer.js"></script>

  <script src="js/all.scripts.js"></script>

</body>
</html>