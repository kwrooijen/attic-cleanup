#!/usr/bin/env ruby
require "fileutils"
require "date"
require "time"

# Check for required gems
begin
  require 'thor'
rescue LoadError
  puts "Thor is not installed"
  puts "Run 'gem install thor'"
  exit 1
end

# require the classes
require File.expand_path("../../lib/attic-cleanup/storage/store_files", __FILE__)
require File.expand_path("../../lib/attic-cleanup/storage/folder_files", __FILE__)
require File.expand_path("../../lib/attic-cleanup/path/custom", __FILE__)
require File.expand_path("../../lib/attic-cleanup/log/log", __FILE__)
require File.expand_path("../../lib/attic-cleanup/initialize/init", __FILE__)

# All the constants and initializers
module MyAttic
  ATTIC     = File.join(ENV["HOME"], "MyAttic")
  TODAY     = File.join(ENV["HOME"], "MyAttic", Date.today.to_s)
  CUSTOM    = File.join(ENV["HOME"], "MyAttic/custom_paths.txt")
  DEFAULT   = File.join(ENV["HOME"], "MyAttic/default_path.txt")
  IGNORE    = File.join(ENV["HOME"], "MyAttic/ignore_files.txt")
  LOG       = File.join(ENV["HOME"], "MyAttic/log.txt")
  
  # Checks if all the folders and files exist, also deletes any empty folders
  AtticCleanup::Init.check_folder(MyAttic::ATTIC)
  AtticCleanup::Init.check_folder(MyAttic::TODAY)
  AtticCleanup::Init.check_file(MyAttic::DEFAULT)
  AtticCleanup::Init.check_file(MyAttic::CUSTOM)
  AtticCleanup::Init.check_file(MyAttic::IGNORE)
  AtticCleanup::Init.clear
  
  # This constant is set after the initializers because it reads
  # the custom_paths.txt file. And it needs to be created first.
  SHORTCUTS = AtticCleanup::Path::Custom.all(MyAttic::CUSTOM)
end