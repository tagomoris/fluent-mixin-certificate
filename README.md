# Fluent::Mixin::Certificate

Fluent::Mixin::Certificate is a mixin-module, that provides certificate/private-key managements for Fluentd plugins.

This module provides:

* configration parameters for SSL certificate/private-key generation
* `#certificate` instance method to return `cert` and `key` values which specified by configuration parameters

## Usage

To use this module in your fluentd plugin, just include this module.

```ruby
module Fluent
  class YourAwesomeInput < Input
    Fluent::Plugin.register_input('your_awesome', self)
    #
    include Fluent::Mixin::Certificate
    ### this 'include' adds these config_param items below.
    # config_param :self_hostname, :string
    #
    # config_param :cert_auto_generate, :bool, :default => false
    # config_param :generate_private_key_length, :integer, :default => 2048
    #
    # config_param :generate_cert_country, :string, :default => 'US'
    # config_param :generate_cert_state, :string, :default => 'CA'
    # config_param :generate_cert_locality, :string, :default => 'Mountain View'
    # config_param :generate_cert_common_name, :string, :default => nil
    #
    # config_param :cert_file_path, :string, :default => nil
    # config_param :private_key_file, :string, :default => nil
    # config_param :private_key_passphrase, :string, :default => nil
  end
end
```

This module use `self_host` parameter to generate common name of certificates. This is a required configuration parameter.

Moreover, just one of `cert_auto_generate yes` or `cert_file_path PATH` must be specified.

## AUTHOR / CONTRIBUTORS

* AUTHOR
  * TAGOMORI Satoshi <tagomoris@gmail.com>

## LICENSE

* Copyright: Copyright (c) 2014- tagomoris
* License: Apache License, Version 2.0
