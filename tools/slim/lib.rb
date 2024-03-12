#!/usr/bin/env ruby
require "date"
require "time"
require "json"
require "psych"
require "slim"
require_relative "helpers"

begin
  # puts $LOAD_PATH
  $TEMPLATES_PATH = ARGV.first
  $LOCALES_PATH = ARGV.last

  I18n.load_path += Dir[$LOCALES_PATH]
  I18n.default_locale = :en

  contents = Psych.safe_load(STDIN.read, permitted_classes: [Date, Time], symbolize_names: true)
  compiled_html = SlimHelpers.render_template(contents[:layout], contents)

  puts compiled_html
rescue => e
  STDERR.puts "Error compiling Slim template: #{e.message}"
  exit 1
end
