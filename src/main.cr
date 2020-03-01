# The main point of entry.

# Standard libraries
require "option_parser"
require "colorize"

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
require "./stag/formatter/**"
require "./stag/operation/**"
require "./stag/action/**"

require "./stag/interface/**"

require "./stag/application"


def Crecto::DbLogger.log(string, elapsed) : Nil
  @@log_handler.as(IO) << [
    "  DB  ".colorize(:blue),
    ("%7.7s" % elapsed_text(elapsed)).colorize(:dark_gray),
    string,
    "\n"
  ].join(" ")
end


# Init
Stag::Application.call(ARGV)

