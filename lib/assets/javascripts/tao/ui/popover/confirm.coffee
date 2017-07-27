class Tao.Popover.Confirm extends Tao.Popover.Element

  @tag 'tao-confirm-popover'

  _connected: ->
    super

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

TaoComponent.register Tao.Popover.Confirm
