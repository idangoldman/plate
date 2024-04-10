#!/usr/bin/env ruby

require "active_support/all"
require "cgi"
require "date"
require "fileutils"
require "json"
require "logger"
require "ostruct"
require "psych"
require "slim"
require "uri"

Dir[File.join( File.dirname( __FILE__ ), "**/*.rb" )].each do |file|
  require file unless file == __FILE__
end

begin
  SLIM_PATHs = JSON.parse( ARGV[0], symbolize_names: true )
  LOG = Utils.create_logger( "slim.log" )

  Utils.set_slim
  Utils.set_locales

  puts Utils.compile_slim_to_html
rescue StandardError => e
  warn "
    Error compiling Slim template: #{e.message}
    #{e.backtrace.join( "\n" )}
  "
  exit 1
end
