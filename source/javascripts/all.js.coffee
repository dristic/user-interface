#= require_tree .

window.onload = () ->
  $ = (selector) ->
    els = document.querySelectorAll selector

    if els.length is 1
      els[0]
    else
      els

  boxes = $ ".box"
  i = -1

  removeNext = () ->
    i = i + 1
    box = boxes[i]
    box?.className = "box"

    if i < boxes.length
      setTimeout removeNext, 200

  setTimeout removeNext, 200

  new Menu $('.menu'), $('.menu-trigger')

class Menu
  constructor: (@el, @trigger) ->
    @closed = @el.className.match('closed')?

    @trigger.onclick = (event) =>
      if @closed
        @closed = false
        document.body.className = document.body.className.replace('menu-closed', 'menu-opened').trim()
        @el.className = @el.className.replace('closed', 'opened').trim()
      else
        @closed = true
        document.body.className = document.body.className.replace('menu-opened', 'menu-closed').trim()
        @el.className = @el.className.replace('opened', 'closed').trim()