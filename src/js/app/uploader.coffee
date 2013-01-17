class Uploader
	constructor: (@generator)->
		@initializeTarget()
		@initializePreviewImage()
		@dragReady = true
		@processing = false

	initializePreviewImage: =>
		previewImage = @target.find '#preview'

		previewImage.on 'dragstart', =>
			setTimeout =>
				@dragReady = false
			, 1

		previewImage.on 'dragend', =>
			@dragReady = true

	initializeTarget: =>
		@target = $('#preview-container')
		@collection = $()

		@target.on 'dragenter', @handleDragEnter
		@target.on 'dragover', @handleDragOver
		@target.on 'dragleave', @handleDragLeave
		@target.on 'drop', @handleDrop

	handleDragEnter: (e) =>
		if @dragReady
			unless @collection.size()
				@target.addClass 'drag-over'

			@collection = @collection.add e.target

	handleDragOver: (e) =>
		e.preventDefault();

	handleDragLeave: (e) =>
		setTimeout =>
			@collection = @collection.not e.target
			unless @collection.size()
				@target.removeClass 'drag-over'
		, 0

	handleDrop: (e) =>
		e.stopPropagation()
		e.preventDefault()

		@target.addClass 'dropped'
		@collection = $()
		@target.removeClass 'drag-over'

		@processFile file for file in e.originalEvent.dataTransfer.files

		return false

	processFile: (file) =>
		if @processing
			setTimeout =>
				@processFile(file)
			, 30
		else
			@processing = true
			if !file.type.match /^image\/(png|jpg|jpeg|gif)$/
				alert 'GIF, PNG, and JPG only.'
				return

			reader = new FileReader()

			reader.addEventListener 'load', (e) =>
				data = e.target.result

				image = new Image
				image.src = data

				$(image).on 'load', =>
					@generator.addFile
						rawName: file.name
						name: file.name.substr 0, file.name.lastIndexOf('.')
						data: data
						size:
							width: image.width
							height: image.height

					@processing = false

			reader.readAsDataURL file