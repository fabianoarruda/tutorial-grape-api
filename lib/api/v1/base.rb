module Api
  module V1
    class Base < Grape::API

      prefix 'api'
      version 'v1'
      format :json

      mount Manufacturers

    end
  end
end
