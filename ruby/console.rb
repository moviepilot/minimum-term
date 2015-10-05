#!/usr/bin/env ruby
require 'bundler'
Bundler.require

$:.unshift File.join(File.dirname(__FILE__), "lib")
require "minimum_term"


schema_data = <<SCHEMA
{
  "$schema": "http://json-schema.org/schema#",
  "definitions": {
    "other": {
      "type": "object",
      "properties": { "id": { "type": "number" } },
      "required": [ "id" ]
    }
  },
  "type": "object",
  "properties": {
    "myref": { "$ref": "#/definitions/other" }
  }
}
SCHEMA

data = <<DATA
  {
    "myref": {"id": "Oh god, a string, this should fail" }
  }
DATA

JsonSchema.parse!(JSON.parse(schema_data)).validate!(JSON.parse(data))
puts "Nothing is raised"

binding.pry
