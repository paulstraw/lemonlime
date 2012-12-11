class Options
	constructor: ->
		@setupHvPicker()

	setupHvPicker: =>
		picker = $('#hv-picker')
		@current = picker.find('.vertical')

		picker.on 'click', 'button', @handleHvSwitch

		@current.trigger('click')

	handleHvSwitch: (e) =>
		e.preventDefault()
		el = $(e.currentTarget)

		if el.hasClass 'current'
			return

		el.siblings().removeClass 'current'
		el.addClass 'current'

		@layout = el.data 'layout'

		$('body').trigger 'optionChange'
