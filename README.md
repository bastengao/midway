# Midway

Download file through Digitalocean and Qiniu to help your get cross the wall.

## Installation

Install it yourself as:

    $ gem install midway

## Usage

```
midway init
# edit ~/.midway.yml

midway dl [the url you want to download]
```

## How it work

1. Create DigitalOcean Droplet
2. Download file from vps
3. Upload file to Qiniu Bucket
4. Download file from Qiniu
5. Drop DigitalOcean Droplet

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/midway. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
