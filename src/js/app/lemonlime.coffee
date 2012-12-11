$(document).ready ->
	if typeof window.FileReader == 'undefined'
		alert 'Your browser doesn\'t have FileReader support. Now\'s a great time to try Chrome!'
		return

	options = new Options()
	cssifier = new Cssifier()
	generator = new Generator(cssifier, options)
	uploader = new Uploader(generator)