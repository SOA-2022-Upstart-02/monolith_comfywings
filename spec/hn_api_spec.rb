# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/rg'
require 'yaml'
require 'date'
require_relative '../lib/hn_api'

STORY_ID = 8863
CORRECT = YAML.safe_load_file('spec/fixtures/hn_results.yml')

describe 'Test Hacker News API library' do
  describe 'Story information' do
    it 'HAPPY: should provide correct story attributes' do
      story = StoryGrabber::HNApi.new.story(STORY_ID)
      _(story.title).must_equal CORRECT['title']
      _(story.score).must_equal CORRECT['score']
      _(story.url).must_equal CORRECT['url']
      _(story.timestamp).must_equal Time.at(CORRECT['timestamp']).to_datetime
      _(story.no_comments).must_equal CORRECT['no_comments']
    end

    it 'SAD: should raise an exception on an invalid story id' do
      _(proc do
        StoryGrabber::HNApi.new.story(0)
      end).must_raise StoryGrabber::HNApi::Errors::NullData
    end
  end
end
