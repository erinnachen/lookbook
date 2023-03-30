$:.push File.expand_path("lib", __dir__)

require "lookbook/version"

Gem::Specification.new do |spec|
  spec.name = "lookbook"
  spec.version = Lookbook::VERSION
  spec.authors = ["Mark Perkins"]
  spec.homepage = "https://github.com/ViewComponent/lookbook"
  spec.summary = "A native development UI for ViewComponent"
  spec.license = "MIT"
  spec.metadata = {"rubygems_mfa_required" => "true"}

  spec.files = Dir["{app,config,assets,lib,public}/**/*", "LICENSE.txt", "README.md"]
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.7.0"

  spec.add_dependency "css_parser"
  spec.add_dependency "concurrent-ruby"
  spec.add_dependency "activemodel"
  spec.add_dependency "zeitwerk", "~> 2.5"
  spec.add_dependency "railties", ">= 5.0"
  spec.add_dependency "view_component", ">= 2.0"
  spec.add_dependency "redcarpet", "~> 3.5"
  spec.add_dependency "rouge", ">= 3.26", "< 5.0"
  spec.add_dependency "yard", "~> 0.9.25"
  spec.add_dependency "htmlbeautifier", "~> 1.3"
  spec.add_dependency "htmlentities", "~> 4.3.4"
end
