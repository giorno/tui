
task default: %w[test]

task :test do
  # Models
  ruby "test/model/testbase.rb"
  ruby "test/model/testboolean.rb"
  ruby "test/model/testcontainer.rb"
  ruby "test/model/testinteger.rb"
  ruby "test/model/teststring.rb"
  ruby "test/model/testenum.rb"
  ruby "test/model/teststruct.rb"

  # core classes
  ruby "test/core/testkeymaker.rb"
  ruby "test/core/testterm.rb"
  ruby "test/core/testtreenode.rb"

  # Views
  ruby "test/testtree.rb"
end
