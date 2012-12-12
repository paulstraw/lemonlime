class Uploader
	constructor: (@generator)->
		@initializeTarget()

	initializeTarget: =>
		@target = $('#preview-container')

		@target.on 'dragenter', @handleDragEnter
		@target.on 'dragleave', @handleDragLeave
		@target.on 'drop', @handleDrop

	handleDragEnter: (e) =>
		console.log e
		@target.addClass 'drag-over'

	handleDragLeave: (e) =>
		@target.removeClass 'drag-over'

	handleDrop: (e) =>
		e.preventDefault()

		@target.addClass 'dropped'
		@target.removeClass 'drag-over'

		@processFile file for file in e.originalEvent.dataTransfer.files

		return false

	processFile: (file) =>
		if !file.type.match /^image\/(png|jpg|jpeg|gif)$/
			alert 'GIF, PNG, and JPG only.'
			return

		reader = new FileReader()

		reader.addEventListener 'load', (e) =>
			setTimeout =>
				@generator.addFile
					rawName: file.name
					name: file.name.substr 0, file.name.lastIndexOf('.')
					data: e.target.result
			, 100

		reader.readAsDataURL file