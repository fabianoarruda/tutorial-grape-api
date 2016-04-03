module Api
  module V1
    class Manufacturers < Grape::API

      resource :manufacturers do

        desc "Return a list of manufacturers."
        get do
          manufacturers = Manufacturer.all
          present manufacturers
        end

        desc "Return a manufacturer."
        params do
          requires :id, type: Integer, desc: "Manufacturer id."
        end
        route_param :id do
          get do
            manufacturer = Manufacturer.find(params[:id])
            present manufacturer
          end
        end

      end
    end
  end
end
