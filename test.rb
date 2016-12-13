require 'parser/current'

cat = <<-EOM
cat
EOM
puts "a #{cat}"
puts "a cat"
options = {}
options['key']
regex = /^(.+)\[/
