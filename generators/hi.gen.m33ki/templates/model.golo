/*--- <%= infos: modelName() %> Model ---*/

var <%= infos: modelName() %>Model = Backbone.Model.extend({
    defaults : function (){
      return {
        <%= infos: defaults() %>
      }
    },
    idAttribute: "_id",
    urlRoot : "<%= infos: modelName(): toLowerCase() %>s"
});

