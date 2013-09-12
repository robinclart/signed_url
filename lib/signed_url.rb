require "uri"
require "openssl"
require "base64"

require "signed_url/version"

class SignedUrl
  def initialize(secret = self.class.secret, options = {})
    @secret = secret
    @digest = options[:digest] || "sha256"
  end

  class << self
    attr_accessor :secret

    def generate(url)
      new.generate(url)
    end

    def verify(url)
      new.verify(url)
    end
  end

  class URL
    def initialize(url)
      @uri = URI(url)
      @query = URI.decode_www_form(@uri.query || "") || []
    end

    def add_param(key, value)
      @query << [key.to_s, value]
      sync_query
    end

    def remove_param(key)
      @query.delete_if { |x| x[0] == key.to_s }
      sync_query
    end

    def to_s
      @uri.to_s
    end

    private

    def sync_query
      query = URI.encode_www_form(@query)
      @uri.query = query == "" ? nil : query
    end
  end

  def generate(url)
    url = URL.new(url)
    url.remove_param :sig
    url.add_param :sig, generate_signature(url.to_s)
    url.to_s
  end

  def verify(url)
    url == generate(url)
  end

  private

  def generate_signature(url)
    ::Base64.encode64(OpenSSL::HMAC.digest(@digest, @secret, url)).strip
  end
end
