
Gem::Specification.new do |s|
  s.name        = 'tui'
  s.version     = '0.1-beta'
  s.licenses    = [ 'Apache 2.0' ]
  s.summary     = "Terminal User Interface"
  s.description = "Create lightweight terminal interfaces"
  s.authors     = [ "Jan Stanik" ]
  s.email       = 'js@creat.io'
  s.files       = [ 'README.md', 'LICENSE' ] + `git ls-files src -z`.split( "\0" )
  s.require     = 'src'
  s.homepage    = 'https://github.com/giorno/tui'
end

