#= require_tree .

###
# Selectors and base classes.
###
class Selected
  constructor: (@el) ->
    # Nothing here

  hasClass: (className) ->
    @el.className.match(className) != -1

  addClass: (classes...) ->
    @el.className = "#{@el.className} #{className}".trim() for className in classes

  removeClass: (className) ->
    regex = new RegExp className, 'g'
    @el.className = @el.className.replace(regex, '').trim()

  attr: (name, value) ->
    if value isnt undefined
      @el[name] = value
    else
      @el[name]

class SelectedCollection
  constructor: (@els) ->
    @els = Array.prototype.slice.call @els, 0
    @els[index] = new Selected(item) for item, index in @els

  all: () ->
    @els

  each: (func) ->
    for el in @els
      func(el)

for key of Selected.prototype
  SelectedCollection.prototype[key] = (args...) ->
    for el in @els
      el[key](args...)

$ = (selector) ->
  els = document.querySelectorAll selector

  if els.length is 1
    new Selected els[0]
  else
    new SelectedCollection els

# Always returns collection set
$$ = (selector) ->
  els = document.querySelectorAll selector

  new SelectedCollection els

###
# Javascript components.
###
class Tray
  @defaults = {}
  @left = 0
  @right = 1

  constructor: (@tray, @triggers, @options) ->
    @options[key] = Tray.defaults[key] unless @options[key] for key of Tray.defaults

    @tray.addClass "tray", "horizontal", "closed"

    document.body.className = "#{document.body.className} tray-transition tray-closed"

    @closed = @tray.hasClass('closed')

    @triggers.each (selected) =>
      selected.el.onclick = (event) =>
        if @closed
          @closed = false
          document.body.className = document.body.className.replace('tray-closed', 'tray-opened').trim()
          @tray.removeClass 'closed'
          @tray.addClass 'opened'
        else
          @closed = true
          document.body.className = document.body.className.replace('tray-opened', 'tray-closed').trim()
          @tray.removeClass 'opened'
          @tray.addClass 'closed'

class List
  constructor: (@el) ->
    # Nothing yet.

class Popover
  constructor: (@el) ->
    # Nothing yet.

###
# Shimmer base methods and on load initialization.
###
class Shimmer
  constructor: () ->
    @components = [{
      class: Tray
      selector: '.tray:not(.trigger)'
      filter: (collection) ->
        collection.each (el) ->
          id = el.attr 'id'
          triggers = $$ ".tray.trigger.#{id}"
          new Tray el, triggers, el.dataset
    }]

  buildComponents: () ->
    for options in @components
      collection = $$ options.selector
      options.filter collection

previousLoad = window.onload
window.onload = () ->
  previousLoad() unless not previousLoad

  window.shim = new Shimmer
  window.shim.buildComponents()

  #new Tray 
    #el: $('#menu').el
    #trigger: $('#trigger').el
    #direction: Tray.left