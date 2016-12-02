require "thor"

module Midway

   class Cli < Thor
     include Thor::Actions

     desc "init", "init configuration file"
     def init()
       copy_file 'midway.yml', '~/.midway.yml'
       puts "Edit ~/.midway.yml"
     end

     desc "dl URL", "download file from URL"
     def dl(url, save_as)
       puts 'url' + url
       puts 'filename ' + save_as
       server = Midway.config['server']
       ssh = Midway::SSH.new(server['host'], server['username'], password: server['password'], port: server['port'])
       ssh.download(url, save_as)
     end


     def self.source_root
       File.expand_path('../templates', __FILE__)
     end
   end
end
