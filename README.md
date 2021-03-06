# OmniAuth::TimeTree

[![Test](https://github.com/koshilife/omniauth-timetree/workflows/Test/badge.svg)](https://github.com/koshilife/omniauth-timetree/actions?query=workflow%3ATest)
[![codecov](https://codecov.io/gh/koshilife/omniauth-timetree/branch/master/graph/badge.svg)](https://codecov.io/gh/koshilife/omniauth-timetree)
[![Gem Version](https://badge.fury.io/rb/omniauth-timetree.svg)](http://badge.fury.io/rb/omniauth-timetree)
[![license](https://img.shields.io/github/license/koshilife/omniauth-timetree)](https://github.com/koshilife/omniauth-timetree/blob/master/LICENSE.txt)

This gem contains the [TimeTree](https://timetreeapp.com/) strategy for OmniAuth.

## Before You Begin

You should have already installed OmniAuth into your app; if not, read the [OmniAuth README](https://github.com/intridea/omniauth) to get started.

Now sign into the [TimeTree Developer Platform](https://developers.timetreeapp.com/en) and create an application. Take note of your API keys.

## Using This Strategy

First start by adding this gem to your Gemfile:

```ruby
gem 'omniauth-timetree'
```

If you need to use the latest HEAD version, you can do so with:

```ruby
gem 'omniauth-timetree', :github => 'koshilife/omniauth-timetree'
```

Next, tell OmniAuth about this provider. For a Rails app, your `config/initializers/omniauth.rb` file should look like this:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :timetree, "API_KEY", "API_SECRET"
end
```

Replace `"API_KEY"` and `"API_SECRET"` with the appropriate values you obtained [earlier](https://timetreeapp.com/oauth/applications).

## Auth Hash Example

The auth hash `request.env['omniauth.auth']` would look like this:

```json
{
  "provider": "timetree",
  "uid": "12345",
  "credentials": {
    "token": "ACCESS_TOKEN",
    "expires": false
  },
  "extra": {
    "raw_info": {
      "data": {
        "id": "12345",
        "type": "user",
        "attributes": {
          "name": "Your Name",
          "description": "blah blah blah",
          "image_url": "https://attachments.timetreeapp.com/path/to/image.png"
        }
      }
    }
  }
}
```

## Contributing

Bug reports and pull requests are welcome on [GitHub](https://github.com/koshilife/omniauth-timetree). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the omniauth-timetree project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/koshilife/omniauth-timetree/blob/master/CODE_OF_CONDUCT.md).
