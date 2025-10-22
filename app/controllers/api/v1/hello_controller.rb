module Api
  module V1
    class HelloController < ApplicationController
      def index
        render json: { message: "Hello World from Ruby on Rails API!" }
      end
    end
  end
end
