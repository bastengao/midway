require 'net/ssh'
require 'uri'
require 'qiniu'

require_relative 'http_utils'

module Midway
  class SSH
    attr_reader :host, :user, :options

    # = Example
    #     Midway::SSH.new('127.0.0.1', 'vagrant', port: 2222)
    #
    def initialize(host, user, options)
      @host = host
      @user = user
      @options = options
    end

    def download(url, filename = nil)
      Net::SSH.start(host, user, options) do |ssh|
        download_qshell(ssh)
        download_file(ssh, url)
        key = upload_to_qiniu(ssh, url)
        download_from_qiniu(key, filename)
      end
    end

    # setup qsheel
    def download_qshell(ssh)
      # TOOD: check qshell installed
      url = "http://78rg9s.com1.z0.glb.clouddn.com/qshell-v1.8.5.tar.gz"
      puts "Download qshell"
      output = ssh.exec!("curl -L #{url} -o qshell-v1.8.1.tar.gz") do |channel, stream, data|
        if stream == :stdout || stream == :stderr
          $stdout.print data
        end
      end
      qshell_home = Midway.config['qiniu']['qshell_home']
      puts ssh.exec!("mkdir -p #{qshell_home} && tar -zxf qshell-v1.8.1.tar.gz --strip-components=1 -C #{qshell_home}")
    end

    def download_file(ssh, url)
      puts "\nDownload file " + url
      ssh.exec!("curl -OL #{url}") do |channel, stream, data|
        if stream == :stdout || stream == :stderr
          $stdout.print data
        end
      end
    end

    def upload_to_qiniu(ssh, url)
      uri = URI(url)
      filename = File.basename(uri.path)
      qshell_home = Midway.config['qiniu']['qshell_home']
      bucket = Midway.config['qiniu']['bucket']
      config_qiniu_account(ssh)
      puts "\nUpload file to Qiniu"
      puts ssh.exec!("cd #{qshell_home} && ./qshell_linux_amd64 rput #{bucket} #{filename} ~/#{filename}")
      filename
    end

    def download_from_qiniu(key, filename)
      bucket = Midway.config['qiniu']['bucket']
      ak = Midway.config['qiniu']['ak']
      sk = Midway.config['qiniu']['sk']
      Qiniu.establish_connection! access_key: ak, secret_key: sk
      url = Qiniu.download(bucket, key)
      HttpUtils.download(url, filename)
    end

    def config_qiniu_account(ssh)
      qshell_home = Midway.config['qiniu']['qshell_home']
      ak = Midway.config['qiniu']['ak']
      sk = Midway.config['qiniu']['sk']
      puts ssh.exec!("mkdir -p #{qshell_home} && cd #{qshell_home} && #{qshll_path} account #{ak} #{sk}")
    end

    def qshll_path
      qshell_home = Midway.config['qiniu']['qshell_home']
      "#{qshell_home}/qshell_linux_amd64"
    end
  end
end
