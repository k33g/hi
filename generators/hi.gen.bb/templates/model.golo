/*--- <%= infos: modelName() %> Model ---*/

var <%= infos: modelName() %>Model = Backbone.Model.extend({
    defaults : function (){
      return {
        <%= infos: defaults() %>
      }
    },
    urlRoot : "<%= infos: modelName(): toLowerCase() %>s"
});

