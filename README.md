[![Build Status](https://travis-ci.org/yogahp/TempMailRu.svg?branch=master)](https://travis-ci.org/yogahp/TempMailRu)

# TempMailRu 

Ruby client for [TempMailRu](https://temp-mail.ru/)

## Usage

### Get Domains

```ruby
require 'tempmailru/api'

tempmailru_api = TempMailRu::Api.new(nil, "http")
tempmailru_api.domains
```

### Get Inbox

```ruby
require 'tempmailru/api'

tempmailru_api = TempMailRu::Api.new(nil, "http")
domain = tempmailru_api.domains[0]
tempmailru_api = TempMailRu::Api.new("test#{domain}")
tempmailru_api.inbox
```

### Get Source

```ruby
require 'tempmailru/api'

tempmailru_api = TempMailRu::Api.new(nil, "http")
domain = tempmailru_api.domains[0]
tempmailru_api = TempMailRu::Api.new("test#{domain}")
tempmailru_api.source
```

### Delete Inbox

```ruby
require 'tempmailru/api'

tempmailru_api = TempMailRu::Api.new(nil, "http")
domain = tempmailru_api.domains[0]
tempmailru_api = TempMailRu::Api.new("test#{domain}")
tempmailru_api.delete
```

[Here](https://temp-mail.ru/api) is TempMailRu API specification.

## Contributing

1. Fork it ( https://github.com/yogahp/TempMailRu/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
