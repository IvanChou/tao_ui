import { Component } from '@mycolorway/tao'
import $ from 'jquery'

class TreeElement extends Component

  @tag 'tao-tree'

  @attribute 'associatedSelect', type: 'boolean'

  @get 'selectedItems', ->
    if @associatedSelect
      @_getAssociatedSelectedItems()
    else
      @jq.find('.tao-tree-item[selected]').get()

  _connected: ->
    @_bind()

  _disconnected: ->
    @off()

  _bind: ->
    @on 'tao-tree-item:selectedChange', '.tao-tree-item', (e) =>
      item = e.currentTarget
      return unless item == e.target
      @_refreshAssociatedItems(item) if @associatedSelect
      @namespacedTrigger 'selectedChange', [@selectedItems]
      null

    @on 'tao-tree-item:listUpdate', '.tao-tree-item', (e) =>
      item = e.currentTarget
      return unless item == e.target
      @_refreshDescendantItems(item) if @associatedSelect

  _refreshAssociatedItems: (item) ->
    @_refreshDescendantItems(item)
    @_refreshAncestorItems(item)

  _refreshDescendantItems: (item) ->
    item.jq.find('.tao-tree-item').prop('selected', item.selected)

  _refreshAncestorItems: (item) ->
    $parentItem = $(item).parent().closest('.tao-tree-item', @)
    return unless $parentItem.length > 0

    $items = $parentItem.find('> .tao-tree-list > .tao-tree-item')
    if $items.filter('[selected], [indeterminate]').length == 0
      $parentItem.prop 'selected', false
      $parentItem.prop 'indeterminate', false
    else if $items.filter(':not([selected])').length == 0
      $parentItem.prop 'selected', true
      $parentItem.prop 'indeterminate', false
    else
      $parentItem.prop 'selected', false
      $parentItem.prop 'indeterminate', true

    @_refreshAncestorItems $parentItem

  _getAssociatedSelectedItems: ($list = @jq.find('> .tao-tree-list')) ->
    selectedItems = []
    $list.find('> .tao-tree-item:not(.tao-tree-loading)').each (i, item) =>
      if item.selected
        selectedItems.push item
      else if ($childList = item.jq.find('> .tao-tree-list')).length > 0
        selectedItems = selectedItems.concat @_getAssociatedSelectedItems($childList)
    selectedItems


export default TreeElement.register()
