require 'parser/current'

cat = <<-EOM
cat
EOM
puts "a #{cat}"
puts "a cat"
options = {}
options['key']
regex = /^(.+)\[/
function('args')
Puppet::ParseError "Something went wrong with parsing"
Puppet::Error "Something went wrong"
Puppet::Debug "Something happened"
ArgumentError "Bad argument"
fail('Something went wrong')
raise Puppet::ParseError "Oh snap!"

something = "something"

case testvar
when "onething"
  function()
  raise Puppet::Error "Something when wrong here"
when "anotherthing"
  function2()
end
