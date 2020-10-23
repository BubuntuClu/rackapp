# frozen_string_literal: true

require 'rubygems'
require 'bundler'
Bundler.require

require './app'
require './secret_folder/secret_logger'
require './secret_folder/secret_static'
require './secret_folder/secret_errors'

use SecretFolder::SecretLogger, logger: Logger.new(File.expand_path('log/app.log', __dir__))
# use SecretFolder::SecretLogger, logger: Logger.new(StringIO.new)
use SecretFolder::SecretStatic
use SecretFolder::SecretErrors
run App.new
