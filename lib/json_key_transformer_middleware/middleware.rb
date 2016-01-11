module JsonKeyTransformerMiddleware

  class Middleware
    def deep_transform_hash_keys(subject, strategy)
      if subject.is_a?(Hash)
        subject.inject({}) do |memo, (key, value)|
          new_key = send(strategy, key)
          memo[new_key] = deep_transform_hash_keys(value, strategy)
          memo
        end
      elsif subject.is_a?(Array)
        subject.inject([]) do |memo, item|
          memo << deep_transform_hash_keys(item, strategy)
          memo
        end
      else
        subject
      end
    end

    # 'keyName' -> 'key_name'
    def camel_to_underscore(key)
      key.gsub(/([A-Z])/) { "_#{$1}" }.downcase
    end

    # 'key_name' -> 'keyName'
    def underscore_to_camel(key)
      key.gsub(/_([a-z0-9])/) { $1.upcase }
    end
  end

end
