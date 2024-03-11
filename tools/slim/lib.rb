#!/usr/bin/env ruby
require "date"
require "time"
require "json"
require "psych"
require "slim"
require "slim/translator"
require_relative "helpers"

begin
  # puts $LOAD_PATH
  $TEMPLATES_PATH = ARGV.first
  contents = Psych.safe_load(STDIN.read, permitted_classes: [Date, Time], symbolize_names: true)

  compiled_html = SlimHelpers.render_template(contents[:layout], contents)
rescue => e
  STDERR.puts "Error compiling Slim template: #{e.message}"
  exit 1
end
