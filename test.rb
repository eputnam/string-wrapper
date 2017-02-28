require 'parser/current'

cat = _(<<-EOM)
cat
EOM
puts _("a #{cat}")
puts _("a cat")
options = {}
options['key']
regex = /^(.+)\[/
function('args')
Puppet::ParseError _("Something went wrong with parsing")
Puppet::Error _("Something went wrong")
Puppet::Debug _("Something happened")
ArgumentError _("Bad argument")
fail(_('Something went wrong'))
raise Puppet::ParseError _("Oh snap!")


case testvar
when _("onething")
  function()
  raise Puppet::Error _("Something when wrong here")
when _("anotherthing")
  function2()
end
