module Api
  module V1
    class PostsController < Api::V1::ApiController
      before_action :doorkeeper_authorize!, except: %i[create]

      def index
      end

      def show
      end

      def create
      end

      def update
      end

      def destroy
      end

    end
  end
end
