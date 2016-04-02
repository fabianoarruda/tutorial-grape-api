module Api
  module V1
    class Manufacturers < Grape::API

      resource :manufacturers do

        desc "Return a list of manufacturers."
        get do
          manufacturers = Manufacturer.all
          present manufacturers
        end

      end
    end
  end
end
