#= require_tree .
#= require_self

###
# Javascript components.
###
class Tray
  @defaults = {}
  @left = 0
  @right = 1

  constructor: (@tray, @triggers, @options) ->
    @options[key] = Tray.defaults[key] unless @options[key] for key of Tray.defaults

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