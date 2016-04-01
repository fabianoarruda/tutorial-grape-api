class CatalogController < ApplicationController
  def index
    @vehicles = Vehicle.all
  end
end
