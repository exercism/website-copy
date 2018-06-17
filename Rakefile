require "rake/testtask"

desc "Run the tests"
task :test do
  bad_files = []
  require 'json'
  Dir['mentors/**/*.json'].each do |file|
    begin
      JSON.parse(File.read(file))
    rescue
      bad_files << file
    end
  end
  unless bad_files.empty?
    puts "JSON is invalid in:"
    bad_files.each do |bad_file|
      STDERR.puts "- %s" % bad_file
    end
    exit 1
  end
end

task :default => :test
