require 'fluent/config'
require 'fluent/mixin/config_placeholders'

module Fluent
  module Mixin
    module Certificate
      def self.included(mod)
        mod.config_param :self_hostname, :string

        mod.config_param :cert_auto_generate, :bool, :default => false
        mod.config_param :generate_private_key_length, :integer, :default => 2048

        mod.config_param :generate_cert_country, :string, :default => 'US'
        mod.config_param :generate_cert_state, :string, :default => 'CA'
        mod.config_param :generate_cert_locality, :string, :default => 'Mountain View'
        mod.config_param :generate_cert_common_name, :string, :default => nil

        mod.config_param :cert_file_path, :string, :default => nil
        mod.config_param :private_key_file, :string, :default => nil
        mod.config_param :private_key_passphrase, :string, :default => nil
      end

      def initialize
        super
        require 'openssl'
      end

      def configure(conf)
        super

        raise Fluent::ConfigError, "self_hostname missing" unless @self_hostname

        if ! @cert_auto_generate and ! @cert_file_path
          raise Fluent::ConfigError, "Both of cert_auto_generate and cert_file_path are not specified. See README."
        end
      end

      def certificate
        return @cert, @key if @cert && @key

        if @cert_auto_generate
          @generate_cert_common_name ||= @self_hostname

          key = OpenSSL::PKey::RSA.generate(@generate_private_key_length)

          digest = OpenSSL::Digest::SHA1.new
          issuer = subject = OpenSSL::X509::Name.new
          subject.add_entry('C', @generate_cert_country)
          subject.add_entry('ST', @generate_cert_state)
          subject.add_entry('L', @generate_cert_locality)
          subject.add_entry('CN', @generate_cert_common_name)

          cer = OpenSSL::X509::Certificate.new
          cer.not_before = Time.at(0)
          cer.not_after = Time.at(0)
          cer.public_key = key
          cer.serial = 1
          cer.issuer = issuer
          cer.subject  = subject
          cer.sign(key, digest)

          @cert = cer
          @key = key
          return @cert, @key
        end

        @cert = OpenSSL::X509::Certificate.new(File.read(@cert_file_path))
        @key = OpenSSL::PKey::RSA.new(File.read(@private_key_file), @private_key_passphrase)
        return @cert, @key
      end
    end
  end
end
