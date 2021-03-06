import PopoverElement from './element'

class ConfirmPopoverElement extends PopoverElement

  @tag 'tao-confirm-popover'

  _connected: ->
    super()

    @on 'click', '.button-confirm', (e) =>
      @namespacedTrigger 'confirm'
      @active = false
      null

    @on 'click', '.button-cancel', (e) =>
      @namespacedTrigger 'cancel'
      @active = false
      null

  setContent: (content) ->
    @jq.find('.tao-popover-content .message').empty()
      .append content
    @

export default ConfirmPopoverElement.register()
