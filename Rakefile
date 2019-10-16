require "rake/testtask"

desc "Run the tests"
task :test do
  errors = []
  require 'json'
  Dir['mentors/**/*.json'].each do |file|
    begin
      filename = File.basename(file).downcase[0]
      mentors = JSON.parse(File.read(file))

      next if mentors.empty?

      if mentors.is_a?(Hash)
        errors << "JSON should be an array of mentors, not a JSON object in %s." % file
        next
      end

      mentors.each do |mentor|
        github_username = mentor["github_username"].to_s
        name = mentor["name"].to_s

        if github_username.empty?
          errors << "Github username can't be blank for %s." % [file]
          next
        end

        unless github_username.downcase.start_with?(filename)
          errors << "First letter of github_username \"%s\" must equal JSON filename %s" % [github_username, file]
          next
        end

        if name.empty?
          errors << "Name can't be blank for %s in %s." % [github_username, file]
          next
        end

        link_text = mentor["link_text"].to_s
        link_url = mentor["link_url"].to_s
        if link_url.empty?
          if !link_text.empty?
            errors << "\"link_text\" should be null since \"link_url\" is null/empty for %s in %s." % [github_username, file]
          end
          next
        end

        if link_url.strip == "null"
          errors << "Link URL should be null, not the string 'null' for %s in %s." % [github_username, file]
          next
        end

        if link_url.strip != link_url
          errors << "Link URL has extraneous whitespace for %s in %s." % [github_username, file]
          next
        end

        if link_url !~ /^https?/
          errors << "Link URL must have HTTP protocol for %s in %s." % [github_username, file]
        end

        if link_text.downcase.gsub(/https?\:\/\//,"") == link_url.downcase.gsub(/https?\:\/\//,"")
          errors << "Use null for \"link_text\" when equivalent to \"link_url\" for %s in %s." % [github_username, file]
          next
        end

        if link_text.downcase.include?("github") && !link_text.include?("GitHub")
          errors << "Capitalization of GitHub is incorrect in \"link_text\" for %s in %s." % [github_username, file]
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
