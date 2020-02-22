# The main point of entry.

# Standard libraries
require "option_parser"

# Shard libraries
require "sqlite3"
require "crecto"

# Internal
require "./stag"

require "./stag/concern/**"

require "./stag/options"
require "./stag/router"

require "./stag/repository"
require "./stag/model/**"

require "./stag/operation/**"

require "./stag/action/**"

require "./stag/application"

# Init
Stag::Application.call(ARGV)

