module Api
  module V1
    class Vehicles < Grape::API

      resource :vehicles do

        desc "Return a list of vehicles."
        get do
          vehicles = Vehicle.all
          present vehicles, with: Entities::Vehicle
        end

        desc "Return a vehicle."
        params do
          requires :id, type: Integer, desc: "Vehicle id."
        end
        route_param :id do
          get do
            vehicle = Vehicle.find(params[:id])
            present vehicle, with: Entities::Vehicle
          end
        end

        desc "Create a new Vehicle"
        params do
          requires :model, type: String
          requires :description, type: String
          requires :manufacturer_id, type: Integer
          optional :price, type: BigDecimal
        end
        post do
          vehicle = Vehicle.new(params)
          if vehicle.save
            present vehicle, with: Entities::Vehicle
          end
        end

      end
    end
  end
end
