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
          requires :image, type: Rack::Multipart::UploadedFile
          optional :price, type: BigDecimal
        end
        post do
          new_file = ActionDispatch::Http::UploadedFile.new(params[:image])
          params.delete(:image)
          vehicle = Vehicle.new(params)
          vehicle.image = new_file

          if vehicle.save
            present vehicle, with: Entities::Vehicle
          end
        end

        desc "Updates an existing vehicle"
        params do
          requires :id, type: Integer
          optional :model, type: String
          optional :description, type: String
          optional :manufacturer_id, type: Integer
          optional :image, type: Rack::Multipart::UploadedFile
          optional :price, type: BigDecimal
        end

        patch ':id' do
          if params[:image]
            new_file = ActionDispatch::Http::UploadedFile.new(params[:image])
            params.delete(:image)
          end
          vehicle = Vehicle.find(params[:id])
          vehicle.assign_attributes(params)
          vehicle.image = new_file if new_file

          if vehicle.save
            present vehicle, with: Entities::Vehicle
          end
        end

        desc 'Delete a vehicle'
        params do
          requires :id, type: Integer, desc: 'Vehicle id.'
        end
        delete ':id' do
          Vehicle.find(params[:id]).destroy
          status :no_content
        end

      end
    end
  end
end
