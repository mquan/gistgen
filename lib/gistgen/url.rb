module Gistgen
  class URL
    def self.standardize(url)
      protocol = url.split('.')[0].match(/^(.*):\/\//)
      u1 = (!protocol)? "http://#{url}" : url
      #raise error if protocol && protocol[0] != 'http'

      #remove www subdomain if exist
      u2 = u1.gsub(/^(http|https):\/\/www\./ix,'http://')

      #make sure google.com and google.com/ are the same thing
      u3 = (u2.match(/^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?$/ix))? "#{u2}/" : u2
    end
    
    def self.is_valid?(url)
      url.match(/^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}((:[0-9]{1,5})?\/.*)?$/ix)
    end
    
    def self.is_image?(url)
      url.match(/\.(?:jpg|jpeg|png|gif|tiff|raw|bmp|webp|ai|psd|svg)$/i)
    end
    
    def self.is_multimedia?(url)
      url.match(/\.(?:js|css|mp3|swf|wmv|mov|doc|pdf|ppt|xls|xlsx|docx|eps|ps|ttf|xml)$/i)
    end
    
    def self.is_root?(url)
      url.match(/^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?\/$/ix) #and url.split('.').size == 2
    end
  end
end