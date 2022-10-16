# frozen_string_literal: true

require 'http'
require 'json'
require_relative 'story'

module StoryGrabber
  # API object
  class HNApi
    API_STORY_ROOT = 'https://hacker-news.firebaseio.com/v0/'
    TOP_STORIES = 'topstories.json'

    module Errors
      class NotFound < StandardError; end
      class NullData < StandardError; end
    end

    HTTP_ERROR = {
      404 => Errors::NotFound
    }.freeze

    def story(story_id)
      story_req_url = hn_api_path(hn_item(story_id))
      story_data = call_hn_url(story_req_url).parse
      story_data.nil? ? raise(Errors::NullData) : Story.new(story_data, self)
    end

    def top_stories(num)
      story_list_req_url = hn_api_path(TOP_STORIES)
      story_ids = call_hn_url(story_list_req_url).parse
      story_ids.take(num).map { |id| story(id) }
    end

    private

    def hn_api_path(path)
      "#{API_STORY_ROOT}/#{path}"
    end

    def hn_item(id)
      "item/#{id}.json"
    end

    def call_hn_url(url)
      result =
        HTTP.headers('Accept' => 'application/json',
                     'User-Agent' => 'HN Api Ruby Client 1.0')
            .get(url)

      successful?(result) ? result : raise(HTTP_ERROR[result.code])
    end

    def successful?(result)
      !HTTP_ERROR.keys.include?(result.code)
    end
  end
end
