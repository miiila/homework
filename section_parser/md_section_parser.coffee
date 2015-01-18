class Section
	constructor: (@name) ->
		@text = ''

module.exports.parseMd = (data, parser) ->
	result = []
	for row in data
		switch getHeaderLevel row
			when 1
				insertFunction = toSection
				result.push new Section (parser.render row)
			when 2
				insertFunction = toSubsection
				lastSection = result.pop()
				lastSection.subsections = [] unless lastSection.subsections?
				lastSection.subsections.push new Section (parser.render row)
				result.push lastSection
			else
				result = insertFunction (parser.render row),result

	return result

toSection = (text, result) ->
	last = result.pop()
	last.text += text
	result.push last

	return result

toSubsection = (text, result) ->
	last = result.pop()
	last.subsections = toSection text, last.subsections
	result.push last

	return result

getHeaderLevel = (string) ->
	if string.match(getHeaderRegexp 1) then 1 else if string.match(getHeaderRegexp 2) then 2 else 0

getHeaderRegexp = (level) ->
	return '^#{'+level+'}[^#].*' 