<!DOCTYPE html>
<html>
<head>

  <meta charset="utf-8">
  <title></title>
  <meta name="description" content="generated thanks to hi and golo">
  <meta name="author" content="k33g0rg">

  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

  <link rel="stylesheet" href="js/vendors/bootstrap/css/bootstrap.min.css">
  <link rel="stylesheet" href="js/vendors/bootstrap/css/bootstrap-theme.min.css">

</head>
<body>
  <div class="container">
    <h1><%= infos: modelName() %></h1>
  </div>
  <div class="container">
    <<%= infos: form_componentName() %>></<%= infos: form_componentName() %>>
    <<%= infos: table_componentName() %>></<%= infos: table_componentName() %>>
  </div>

  <script src="js/vendors/jquery.min.js"></script>
  <script src="js/vendors/underscore.js"></script>
  <script src="js/vendors/backbone.js"></script>
  <script src="js/vendors/bootstrap/js/bootstrap.min.js"></script>
  <script src="js/vendors/react.min.js"></script>
  <script src="js/vendors/JSXTransformer.js"></script>

  <script src="js/all.scripts.js"></script>

  <script type="text/jsx">
      /** @jsx React.DOM */
      React.renderComponent(
        <<%= infos: form_componentName() %>/>,
        document.querySelector('<%= infos: form_componentName() %>')
      );

      React.renderComponent(
        <<%= infos: table_componentName() %> pollInterval={500}/>,
        document.querySelector('<%= infos: table_componentName() %>')
      );
    </script>

</body>
</html>
