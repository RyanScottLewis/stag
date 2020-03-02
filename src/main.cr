# The main point of entry.

# Standard libraries
require "option_parser"
require "colorize"
require "levenshtein"
require "csv"
require "yaml"
require "json"

# Shard libraries
require "sqlite3"
require "crecto"
require "tablo"

# Internal
require "./stag"

require "./stag/concern/**"
require "./stag/options/**"
require "./stag/option_parser/**"

require "./stag/router"
require "./stag/repository"

require "./stag/model/**"

require "./stag/formatter"
require "./stag/formatter/params"
require "./stag/formatter/**"

require "./stag/operation/**"
require "./stag/action/**"

require "./stag/interface/**"

require "./stag/application"

module Crecto::DbLogger

  class_property! options : Stag::Options::Global

  def self.log(string, elapsed) : Nil
    @@log_handler.as(IO) << [
      "DB".ljust(4).colorize(:blue),
      elapsed_text(elapsed).ljust(7).colorize(:dark_gray),
      string,
      "\n"
    ].join(" ") if options.verbose >= Stag::Verbose::DEBUG
  end

end

# Init
Stag::Application.call(ARGV)

