# frozen_string_literal: true

require 'http'
require 'yaml'
require 'json'

def hn_api_path_url(path)
  "https://hacker-news.firebaseio.com/v0/#{path}"
end

# Stories and comments are items
def hn_item(id)
  "item/#{id}.json"
end

def hn_user(username)
  "user/#{username}.json"
end

def call_hn_url(url)
  HTTP.headers(
    'Accept' => 'application/json'
  ).get(url)
end

hn_response = {}
hn_results = {}

## HAPPY story request
TEST_STORY_ID = 8863

story_url = hn_api_path_url(hn_item(TEST_STORY_ID))
hn_response[story_url] = call_hn_url(story_url)
story = JSON.parse hn_response[story_url]

hn_results['title']       = story['title']
hn_results['score']       = story['score']
hn_results['url']         = story['url']
hn_results['timestamp']   = story['time']
hn_results['no_comments'] = story['descendants']

## BAD story request
bad_story_url = hn_api_path_url(hn_item(0))
hn_response[bad_story_url] # null

File.write('spec/fixtures/hn_results.yml', hn_results.to_yaml)