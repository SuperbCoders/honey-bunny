@http =
	get: (url, data) ->
		$.ajax
			type: "GET"
			url: url
			data: data

	post: (url, data) ->
		$.ajax
			type: "POST"
			url: url
			data: data

	patch: (url, data) ->
		data = {} unless data
		data = _.extend(data, {"_method":"patch"})
		$.ajax
			type: "POST"
			url: url
			data: data

	delete: (url, data) ->
		data = {} unless data
		data = _.extend(data, {"_method":"delete"})
		$.ajax
			type: "POST"
			url: url
			data: data

	submitFrom: (e, form) ->
		e.preventDefault()
		form.addClass('loading')
		$.ajax
			url:  form.attr('action')
			type: form.attr('method').toUpperCase()
			data: form.serialize()
			dataType: "json"
			complete: -> form.removeClass('loading')

	searchParams: (search) ->
	  (search || location.search).substring(1).split('&').reduce ((result, value) ->
	    parts = value.split('=')
	    if parts[0]
	      result[decodeURIComponent(parts[0])] = decodeURIComponent(parts[1])
	    result
	  ), {}
