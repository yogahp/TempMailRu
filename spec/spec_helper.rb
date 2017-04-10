$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'tempmailru/api'
require 'sendpulse/smtp'
require 'dotenv'
require 'faker'
Dotenv.load
