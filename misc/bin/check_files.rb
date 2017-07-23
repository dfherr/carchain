#! /usr/bin/env ruby

failures = false

ruby_files = ARGV.grep(/\.rb$|\.ru$|\.rake$|\.gemspec$|Rakefile$|Gemfile$|Capfile$/)
if ruby_files.any?
  puts "### RUBY ###"
  unless system("bin/rubocop --force-exclusion --auto-correct --fail-level autocorrect #{ruby_files.join(' ')}")
    failures = true
  end
  puts ""
end

exit (failures ? 1 : 0)
