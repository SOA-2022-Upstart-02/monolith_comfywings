require 'roda'
require 'slim'

# Remove this line once integrated with api
require 'yaml'

module ComfyWings
  class App < Roda
    plugin :render, engine: 'slim', views: 'app/views'
    plugin :assets, css: 'style.css', path: 'app/views/assets'
    plugin :common_logger, $stderr
    plugin :halt

    route do |routing|
      routing.assets # load CSS
      response['Content-Type'] = 'text/html; charset=utf-8'

      # GET /
      routing.root do
        view 'home'
      end

      routing.on 'flight' do
        # routing.is do
        #   # POST /flight/
        #   routing.post do
            
        #   end
        # end

        # routing.on String, String do |orig, dest|
        #   # GET /flight/{origin}/{destination}
        #   routing.get do
        #     candidate_flights = Amadeus::
        #   end
        # end

        # flight_results = YAML.safe_load_file('../../spec/fixtures/flight_results.yml')

        view 'flight'
      end

    end
  end
end