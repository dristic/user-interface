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

window.$ = $
window.$$ = $$