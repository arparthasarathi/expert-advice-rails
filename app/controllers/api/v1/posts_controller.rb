module Api
  module V1
    class PostsController < Api::V1::ApiController
      before_action :doorkeeper_authorize!, except: %i[create index search show]

      def index
        posts = Post.where(question_id: nil).order(:created_at)

        paginate json: posts, include: ['tags']
      end

      def show
        post = Post.find_by(slug: params[:slug])

        render json: post, include: ['tags', 'answers']
      end

      def search
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
