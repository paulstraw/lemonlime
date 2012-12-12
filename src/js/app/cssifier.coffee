class Cssifier
	constructor: ->
		$('#css-container').find('textarea').on 'focus', @handleTextareaFocus

	handleTextareaFocus: (e) =>
		setTimeout ->
			$(e.currentTarget).select()
		, 0

	cssify: (files) =>
		spriteName = 'sprite'#read from options
		css = ".#{spriteName} { background: url(\"#{spriteName}.png\"); }\n"

		for file in files
			css += ".#{spriteName}.#{file.name} { background-position: -#{file.offset.left}px -#{file.offset.top}px; width: #{file.size.width}px; height: #{file.size.height}px; }\n"

		$('#css-container').find('textarea').html(css)