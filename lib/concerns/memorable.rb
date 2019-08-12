module Memorable
  module ClassMethods
    def find_by_slug(slug)
      result = self.all.select {|elem| elem.slug == slug }.first      
    end
  end

  module InstanceMethods
    def slug
      self.name.downcase.gsub(" ", "-")
    end
  end
end