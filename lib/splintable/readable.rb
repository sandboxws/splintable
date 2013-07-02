module Splintable
  class Readable
    attr_reader :content,
      :raw_content, :title,
      :description, :images
    def initialize(generator)
      @generator = generator
      @author_name = @generator.author_name
      @author_url = @generator.author_url
      @content = @generator.content
      @raw_content = @generator.raw_content
      @title = @generator.title
      @description = @generator.description
      @images = @generator.images
    end
  end
end
