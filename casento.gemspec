#encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'casento/version'

Gem::Specification.new do |spec|
  spec.name          = "casento"
  spec.version       = Casento::VERSION
  spec.authors       = ["Ken-ichi Ueda"]
  spec.email         = ["kenichi.ueda@gmail.com"]

  spec.summary       = "Tool reading the Entomology General Collection Database at the California Academy of Sciences"
  spec.description   = %q{
    The California Academy of Sciences has databased a great deal of the
    entomological specimen data, but it's generally only available through
    their own website with no API and no machine-readable export
    functionality. This gem attempts to ameliorate the sitation by scraping
    data and presenting it as machine-readable data.
  }
  spec.homepage      = "https://github.com/kueda/casento"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.8"
  spec.add_development_dependency "m", "~> 1.4"
  spec.add_runtime_dependency 'nokogiri', "~> 1.6"
  spec.add_runtime_dependency 'activesupport', "~> 4.2"
  spec.add_runtime_dependency 'commander', "~> 4.3"
end
