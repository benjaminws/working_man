module WorkingMan
  class Actions
    @provider = Provider.new
    def self.close_applications apps
      @provider.close_applications apps
    end

    def self.launch_applications apps
      @provider.launch_applications apps
    end

    def self.open_urls urls
      @provider.open_urls urls
    end
  end
end
