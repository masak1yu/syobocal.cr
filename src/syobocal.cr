require "./syobocal/*"
require "http/client"
require "json"
require "xml"

command = ARGV[0]
params = ARGV[1] if ARGV[1]

case command
when "DB::TitleLookup"
  puts Syobocal::DB::TitleLookup.url(params)
  result = Syobocal::DB::TitleLookup.get(params)
  p result
when "JSON::TitleMedium"
  puts Syobocal::JSON::TitleMedium.url(params)
  result = Syobocal::JSON::TitleMedium.get(params)
  p result
when "JSON::TitleFull"
  puts Syobocal::JSON::TitleMedium.url(params)
  result = Syobocal::JSON::TitleMedium.get(params)
  p result
when "JSON::ProgramByPID"
  puts Syobocal::JSON::ProgramByPID.url(params)
  result = Syobocal::JSON::ProgramByPID.get(params)
  p result
end

module Syobocal
  module JSON
    class TitleMedium
      def self.get(params)
        response = HTTP::Client.get(url(params))
        result = ::JSON.parse(response.body)
      end

      def self.url(params)
        "http://cal.syoboi.jp/json.php?Req=TitleMedium" + "&" + params.to_s
      end
    end

    class TitleFull
      def self.get(params)
        response = HTTP::Client.get(url(params))
        result = ::JSON.parse(response.body)
      end

      def self.url(params)
        "http://cal.syoboi.jp/json.php?Req=TitleFull" + "&" + params.to_s
      end
    end

    class ProgramByPID
      def self.get(params)
        response = HTTP::Client.get(url(params))
        result = ::JSON.parse(response.body)
      end

      def self.url(params)
        "http://cal.syoboi.jp/json.php?Req=ProgramByPID" + "&" + params.to_s
      end
    end
  end
end

module Syobocal
  module DB
    class TitleLookup
      def self.get(params)
        response = HTTP::Client.get(url(params))
        parse(response.body)
      end

      def self.url(params)
        "http://cal.syoboi.jp/db.php?Command=TitleLookup" + "&" + params.to_s
      end

      def self.parse(xml)
        ::XML.parse(xml)
      end
    end
  end
end
