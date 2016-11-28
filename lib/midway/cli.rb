require "thor"

module Midway

   class Cli < Thor
       desc "init", "init configuration file"
       def init()
         # TODO: set default file
         `touch ~/.midway.yml`
         puts "Edit ~/.midway.yml"
       end

       desc "dl URL", "download file from URL"
       def dl(url)
         puts 'test' + url
       end
   end
end
