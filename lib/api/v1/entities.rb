module Api
  module V1
    module Entities

      class Manufacturer < Grape::Entity
        expose :id
        expose :name
      end

      class Vehicle < Grape::Entity

        format_with :timestamp do |created_at|
          created_at.strftime("%B%e, %Y at %I:%M %p")
        end

        expose :id
        expose :model
        expose :description
        expose :price
        expose :created_at, :format_with => :timestamp
        expose :image do |vehicle, opts|
          'http://' + opts[:env]['HTTP_HOST'] + vehicle.image.url
        end

        expose :manufacturer, using: Entities::Manufacturer
      end

    end
  end
end
