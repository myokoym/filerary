# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'filerarian/version'

Gem::Specification.new do |spec|
  spec.name          = "filerarian"
  spec.version       = Filerarian::VERSION
  spec.authors       = ["Masafumi Yokoyama"]
  spec.email         = ["myokoym@gmail.com"]
  spec.summary       = %q{A fulltext search tool for local files}
  spec.description   = %q{Filerarian is a fulltext search tool for local files that contains text. For example, .txt, .pdf, .xls and so on.}
  spec.homepage      = "https://github.com/myokoym/filerarian"
  spec.license       = "GPLv3"

  spec.post_install_message = <<-END_OF_MESSAGE
Filerarian will use '#{File.join(File.expand_path("~"), ".filerarian")}' for data storage. Thanks!
  END_OF_MESSAGE

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) {|f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency("grn_mini")
  spec.add_runtime_dependency("poppler")
  spec.add_runtime_dependency("spreadsheet")
  spec.add_runtime_dependency("thor")

  spec.add_development_dependency("bundler", "~> 1.5")
  spec.add_development_dependency("rake")
end
