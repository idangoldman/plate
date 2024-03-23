#!/usr/bin/env ruby
require "date"
require "fileutils"
require "i18n"
require "json"
require "logger"
require "ostruct"
require "psych"
require "slim"
require "time"

require_relative "helpers"
require_relative "locals"
require_relative "utils"

begin
  $SLIM_PATHs = JSON.parse(ARGV[0], object_class: OpenStruct, symbolize_names: true)
  $CONTENTS = STDIN.read

  $LOG = Utils.create_logger("$SLIM_PATHs[:log]/slim.log")

  Locals::setup($CONTENTS, $SLIM_PATHs[:locales], :en)
  Utils.load_locales($SLIM_PATHs[:locales], :en)
  Utils.set_slim()

  puts Utils.compile_slim_to_html()
rescue => e
  STDERR.puts "Error compiling Slim template: #{e.message}"
  exit 1
end