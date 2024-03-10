#!/usr/bin/env ruby
require "slim"
require "json"
require "slim/translator"
require_relative "helpers"

begin
  locals = ARGV[0] ? JSON.parse(ARGV[0]) : {}
  contents = $stdin.read
  compiled_html = SlimHelpers.render_template(contents, locals)

  puts compiled_html
rescue => e
  STDERR.puts "Error compiling Slim template: #{e.message}"
  exit 1
end
