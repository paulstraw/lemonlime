class Generator
	constructor: (@cssifier, @options) ->
		@files = []
		@canvas = $('<canvas>')[0]
		@ctx = @canvas.getContext '2d'
		@previewImage = $('#preview-container').find('img')

		$('body').on 'optionChange', =>
			if @files.length
				@updateSprite()
				@cssifier.cssify(@files)

	addFile: (file) =>
		@files.push file

		@updateSprite()
		@cssifier.cssify(@files)

	updateSprite: =>
		layout = @options.layout #should read from options
		padding = 0 #should read from options
		currentOffset = 0 + padding
		widestImage = 0
		tallestImage = 0
		totalWidth = 0
		totalHeight = 0

		#add padding to totals
		if layout == 'v'
			totalHeight += padding
		else
			totalWidth += padding

		#clear canvas
		@canvas.width = @canvas.width

		#get total width and height to resize canvas
		for file in @files
			image = new Image
			image.src = file.data
			iWidth = image.width
			iHeight = image.height

			if iWidth > widestImage then widestImage = iWidth
			if iHeight > tallestImage then tallestImage = iHeight

			#update file info and totals
			file.size =
				width: iWidth
				height: iHeight

			if layout == 'v'
				file.offset =
					left: 0
					top: totalHeight

				totalWidth = widestImage
				totalHeight += iHeight + padding
			else
				file.offset =
					left: totalWidth
					top: 0

				totalWidth += iWidth + padding
				totalHeight = tallestImage

		#update canvas
		@canvas.width = totalWidth
		@canvas.height = totalHeight

		if layout == 'v'
			@previewImage.css
				maxWidth: 'auto'
				maxHeight: '100%'
		else
			@previewImage.css
				maxWidth: '100%'
				maxHeight: 'auto'

		#draw images to canvas
		for file in @files
			image = new Image
			image.src = file.data
			iWidth = image.width
			iHeight = image.height

			if layout == 'v'
				@ctx.drawImage image, 0, currentOffset
			else
				@ctx.drawImage image, currentOffset, 0
			currentOffset += (if layout == 'v' then iHeight else iWidth) + padding


		@previewImage.attr 'src', @canvas.toDataURL()