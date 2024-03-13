#!/usr/bin/env ruby
require_relative "utils"

begin
  $TEMPLATES_PATH = ARGV.first
  $LOCALES_PATH = ARGV.last
  $CONTENTS = STDIN.read

  Utils.load_locales()
  Utils.set_slim()

  puts Utils.compile_slim_to_html($CONTENTS)
rescue => e
  STDERR.puts "Error compiling Slim template: #{e.message}"
  exit 1
end
