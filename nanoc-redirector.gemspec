lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'version'

Gem::Specification.new do |spec|
  spec.name          = 'nanoc-redirector'
  spec.version       = NanocRedirector::VERSION
  spec.authors       = 'Garen J. Torikian'
  spec.email         = %w(gjtorikian@gmail.com)
  spec.licenses      = ['MIT']

  spec.summary       = %w(Allows you to generate redirects to and from an item.)
  spec.homepage      = 'https://www.github.com/gjtorikian/nanoc-redirector'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'nanoc', '~> 4.0'

  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'minitest', '~> 5.8'
  spec.add_development_dependency 'awesome_print'
end
