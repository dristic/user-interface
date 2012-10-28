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
  constructor: (el, trigger) ->