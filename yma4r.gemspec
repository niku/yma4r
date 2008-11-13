Gem::Specification.new do |s|
  s.name = %q{yma4r}
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["niku"]
  s.date = %q{2008-11-14}
  s.description = %q{yma4r is Yahoo Morphological Analyzer wrapper For Ruby}
  s.email = %q{niku@niku.name}
  s.extra_rdoc_files = ["README", "ChangeLog"]
  s.files = ["README", "ChangeLog", "Rakefile", "test/test_helper.rb", "test/yma4r_test.rb", "lib/yma4r.rb", "lib/yma_parser.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/niku/yma4r}
  s.rdoc_options = ["--title", "yma4r documentation", "--charset", "utf-8", "--opname", "index.html", "--line-numbers", "--main", "README", "--inline-source", "--exclude", "^(examples|extras)/"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{yma4r}
  s.rubygems_version = %q{1.2.0}
  s.summary = %q{yma4r is Yahoo Morphological Analyzer wrapper For Ruby}
  s.test_files = ["test/yma4r_test.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if current_version >= 3 then
      s.add_runtime_dependency(%q<classx>, [">= 0.0.5"])
    else
      s.add_dependency(%q<classx>, [">= 0.0.5"])
    end
  else
    s.add_dependency(%q<classx>, [">= 0.0.5"])
  end
end
