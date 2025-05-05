#! /usr/bin/env ruby

require 'json'

TimeFormat = Struct.new(:title, :value, :identifier) do
	def initialize(*args)
		super(*args.map(&:strip))
	end

	def to_h
		{
			:uid 					=> self.identifier,
			:title					=> self.title,
			:arg						=> self.value,
			:subtitle			=> self.value,
			:autocomplete	=> self.value,
		}
	end

	def to_json(*args)
		to_h.to_json
	end
end

timestamp = ARGV[0] || Time.now.to_i 

FORMATS = [
	TimeFormat.new("From UTC", `date -r #{timestamp}`, "snippets.date.from_utc"),
]

puts ({:items => FORMATS}.to_json)