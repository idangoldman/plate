#!/usr/bin/env ruby

require "active_support/all"
require "date"
require "fileutils"
require "i18n"
require "json"
require "logger"
require "ostruct"
require "psych"
require "slim"

require_relative "template_helpers"
require_relative "locals"
require_relative "utils"

begin
  $CONTENTS = STDIN.read
  $SLIM_PATHs = JSON.parse(ARGV[0], object_class: OpenStruct, symbolize_names: true)
  $LOG = Utils.create_logger("#{$SLIM_PATHs[:logs]}/slim.log")

  Locals::load($CONTENTS)
  Utils.set_slim()

  puts Utils.compile_slim_to_html()
rescue => e
  STDERR.puts """
    Error compiling Slim template: #{e.message}
    #{e.backtrace.join("\n")}
  """
  exit 1
end
