mdSectionParser = require ('./md_section_parser.coffee')
fs = require('fs')
rs = require('robotskirt')

run = (filename,callback) ->
	fs.readFile(filename, 'utf8', (err, data) ->
		if err 
			throw err
		parser = rs.Markdown.std()	
		result = {sections: callback data.split("\n"), parser}
	)

run 'ovoce.md', mdSectionParser.parseMd