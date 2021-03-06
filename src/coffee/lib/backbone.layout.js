Backbone.Layout = Backbone.View.extend({

  // should be html, or a function which returns html
  template: function() {

  },

  initialize: function() {
    Backbone.View.prototype.initialize.apply(this, arguments);
    this.views = this.views || {};
    this.view_references = {};
  },

  // initViews will go through the layouts
  // `views`, creating a new view for each one.
  // it sets the view's `el` as the `el` matched
  // from the selector.
  initViews: function() {
    var views = this.views,
      view;

    for (var selector in views) {
      view = views[selector].apply(this);
      this.setView(selector, view, true);
    };
  },

  // view should be an object or a function which returns an object,
  // and will be used to pass into the template() function
  // layout will automatically try
  // serialize the layout's `model`,
  // or `collection` first
  view: function() {
    var model = this.model? this.model.toJSON():
      (this.collection? this.collection.toJSON(): {});
    return model;
  },

  // the default render action for a layout
  // simply empties the layouts main `$el`,
  // and replaces it's content with the result of
  // the layouts `template` function. it also sets
  // the `id` and `class` of it's $el
  render: function() {
    var $el = this.$el,
      view = this.view.apply? this.view(): this.view,
      template = this.template.apply? this.template(view): this.template;

    $el.empty();
    $el.append(template);
    this.initViews();
    return this;
  },

  // setView uses a selector to find a node,
  // then renders that view using that node as it's parent
  setView: function(selector, view, assigned) {
    var $view = this.$(selector),
      prev_view = this.view_references[selector];

    // when a view is set on an element which already has a view,
    // the element is shared between views. so we are responsible
    // for cleaning up listeners.
    if (prev_view) {
      prev_view.undelegateEvents();
      prev_view.stopListening();
    }

    // set the root element of the view  and save a reference 
    // to the view for subsequent renders
    this.view_references[selector] = view;
    view.setElement($view);
    return view.render();
  }

});