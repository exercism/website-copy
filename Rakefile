require "rake/testtask"

desc "Run the tests"
task :test do
  errors = []
  require 'json'
  Dir['mentors/**/*.json'].each do |file|
    begin
      mentors = JSON.parse(File.read(file))
      next if mentors.empty?

      if mentors.is_a?(Hash)
        errors << "JSON should be an array of mentors, not a JSON object in %s." % file
        next
      end

      mentors.each do |mentor|
        url = mentor["link_url"]
        next if url.nil?

        username = mentor["github_username"]

        if url.strip.empty?
          errors << "Link URL should be null for %s in %s" % [username, file]
          next
        end

        if url.strip == "null"
          errors << "Link URL should be null, not the string 'null' for %s in %s." % [username, file]
          next
        end

        if url.strip != url
          errors << "Link URL has extraneous whitespace for %s in %s." % [username, file]
          next
        end

        if url !~ /^https?/
          errors << "Link URL must have HTTP protocol for %s in %s." % [username, file]
        end

        if mentor["link_text"].to_s.include?("Github")
          errors << "GitHub should be spelled with an uppercase 'H' for %s in %s." % [username, file]
        end
      end
    rescue
      errors << "Invalid JSON in: %s" % file
    end
  end
  unless errors.empty?
    errors.each do |error|
      STDERR.puts "- %s" % error
    end
    exit 1
  end
end

task :default => :test
