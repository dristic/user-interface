#= require_tree .

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

$ = (selector) ->
  els = document.querySelectorAll selector

  if els.length is 1
    new Selected els[0]
  else
    new Selected els

window.onload = () ->
  new Tray 
    el: $('#menu').el
    trigger: $('#trigger').el
    direction: Tray.left

class Tray
  @defaults = {}
  @left = 0
  @right = 1

  constructor: (@options) ->
    @options[key] = Tray.defaults[key] unless @options[key] for key of Tray.defaults

    @el = new Selected @options.el
    @trigger = new Selected @options.trigger

    @trigger.addClass "tray-trigger"
    @el.addClass "tray", "horizontal", "closed"

    document.body.className = "#{document.body.className} tray-transition tray-closed"

    @closed = @el.hasClass('closed')

    @trigger.el.onclick = (event) =>
      if @closed
        @closed = false
        document.body.className = document.body.className.replace('tray-closed', 'tray-opened').trim()
        @el.removeClass 'closed'
        @el.addClass 'opened'
      else
        @closed = true
        document.body.className = document.body.className.replace('tray-opened', 'tray-closed').trim()
        @el.removeClass 'opened'
        @el.addClass 'closed'

class List
  constructor: (@el) ->
    # Nothing yet.

class Popover
  constructor: (@el) ->
    # Nothing yet.