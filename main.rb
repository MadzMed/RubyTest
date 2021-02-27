require 'json'

data = JSON.parse(File.open('data.json').read)

output_file = File.open('output.json', 'w')
output_file.write()