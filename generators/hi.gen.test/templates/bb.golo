/*--- <%= infos: model_name() %> Model ---*/

var <%= infos: model_name() %> = Backbone.Model.extend({
    defaults : function (){
      return {
        <%= infos: fields(): join(",") %>
      }
    },
    urlRoot : "<%= infos: model_name(): toLowerCase() %>s"
});
