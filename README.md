User Interface
-----------------
A functional mobile UI framework

# Purpose
To provide a JS and CSS framework for creating a functional mobile user interface.

# Usage

    var slide = new UI.SlidePanel('#slidepanel', [opts])
    var grid = new UI.Grid('#grid1', [opts])
    etc...

# Features

## Tray
A sliding tray that can expand from any direction and either overlay or push content along with it.

## Grid
A grid view of items with paging, etc. (Might combine with list view)

## List
A list is a paged or not paged collection of items with touch sliding capability.

## Feed (extends List)
A feed is a list of [n] types of items with paging and refresh capability.

## Popover
A basic popup that responds to touch.

## Radio Selection
A collection of items where only one item can be on at any time.