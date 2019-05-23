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
        term = params[:term]
        posts = Post.tagged_with(term)

        paginate json: posts
      end

      def create
        post = current_user.posts.build(create_post_params)

        post.set_account(current_account.id)

        if post.save
          render json: post, account_user: current_account_user
        else
          render json: post,
                 status: :unprocessable_entity,
                 serializer: ActiveModel::Serializer::ErrorSerializer
        end
      end

      def update
        post = current_user.posts.find_by(slug: params[:slug])

        if post.present?
          post.assign_attributes(update_post_params)
          if post.save
            render json: post, status: :ok, account_user: current_account_user
          else
            render json: post,
                   status: :unprocessable_entity,
                   serializer: ActiveModel::Serializer::ErrorSerializer
          end
        else
          render json: post,
                 status: :forbidden,
                 serializer: ActiveModel::Serializer::ErrorSerializer
        end
      end

      def destroy
      end

      private

      def create_post_params
        params.require(:data).require(:attributes).permit(:title, :body, :question_id, :tag_list)
      end

      def update_post_params
        params.require(:data).require(:attributes).permit(:id, :title, :body, :question_id, :tag_list)
      end
    end
  end
end
