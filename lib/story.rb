# frozen_string_literal: true

require 'date'

module StoryGrabber
  # Object for Hacker News story
  class Story
    def initialize(story_data, data_source)
      @story = story_data
      @data_source = data_source
    end

    def title
      @story['title']
    end

    def score
      @story['score']
    end

    def url
      @story['url']
    end

    def text
      @story['text'] || 'null'
    end

    def timestamp
      Time.at(@story['time']).to_datetime
    end

    def no_comments
      @story['descendants']
    end
  end
end
