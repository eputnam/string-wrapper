require 'parser/current'

cat = _(<<-EOM)
cat
EOM
puts _("a #{cat}")
puts _("a cat")
options = {}
options['key']
regex = /^(.+)\[/
