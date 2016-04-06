module Api
  module V1
    class Base < Grape::API

      prefix 'api'
      version 'v1'
      format :json

      rescue_from ActiveRecord::RecordNotFound do
        rack_response({ 'message' => '404 Not found' }.to_json, 404)
      end

      rescue_from :all do |exception|

        trace = exception.backtrace

        message = "\n#{exception.class} (#{exception.message}):\n"
        message << exception.annoted_source_code.to_s if exception.respond_to?(:annoted_source_code)
        message << "  " << trace.join("\n  ")

        Base.logger.add Logger::FATAL, message
        rack_response({ 'message' => '500 Internal Server Error' }.to_json, 500)
      end

      mount Manufacturers
      mount Vehicles

    end
  end
end
