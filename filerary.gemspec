# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'filerary/version'

Gem::Specification.new do |spec|
  spec.name          = "filerary"
  spec.version       = Filerary::VERSION
  spec.authors       = ["Masafumi Yokoyama"]
  spec.email         = ["myokoym@gmail.com"]
  spec.summary       = %q{A fulltext search tool for local files}
  spec.description   = %q{Filerary is a fulltext search tool for local files that contains text. For example, .txt, .pdf, .xls and so on.}
  spec.homepage      = "https://github.com/myokoym/filerary"
  spec.license       = "LGPLv2.1 or later"

  spec.post_install_message = <<-END_OF_MESSAGE
Filerary will use '#{File.join(File.expand_path("~"), ".filerary")}' for data storage. Thanks!
  END_OF_MESSAGE

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) {|f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency("grn_mini")
  spec.add_runtime_dependency("chupa-text")
  spec.add_runtime_dependency("chupa-text-decomposer-pdf")
  spec.add_runtime_dependency("chupa-text-decomposer-libreoffice")
  spec.add_runtime_dependency("thor")

  spec.add_development_dependency("test-unit")
  spec.add_development_dependency("test-unit-notify")
  spec.add_development_dependency("test-unit-rr")
  spec.add_development_dependency("bundler", "~> 1.5")
  spec.add_development_dependency("rake")
end
