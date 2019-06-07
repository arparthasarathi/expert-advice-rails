module Api
  module V1
    class PostsController < Api::V1::ApiController
      before_action :doorkeeper_authorize!, except: %i[create index search show]

      def index
        posts = Post.where(question_id: nil).order(created_at: :desc)

        paginate json: posts, include: ['tags']
      end

      def show
        post = Post.find_by(slug: params[:slug])

        if post.blank?
          render json: post, status: :not_found,
                 serializer: ActiveModel::Serializer::ErrorSerializer
        end

        post.increment_views_count if post.question?

        render json: post, include: %w[tags answers]
      end

      def search
        term = params[:query]
        posts = Post.tagged_with(term).order(created_at: :desc)

        paginate json: posts, include: ['tags']
      end

      def create
        post = current_user.posts.build(create_post_params)

        post.assign_account(current_account.id)

        if post.save
          render json: post, include: %w[tags question]
        else
          render json: post,
                 status: :unprocessable_entity,
                 serializer: ActiveModel::Serializer::ErrorSerializer
        end
      end

      def update
        update_post_params_with_edited_at = update_post_params.merge(edited_at: Time.now)
        post = current_user.posts.find_by(slug: params[:slug])

        if post.present?
          post.assign_attributes(update_post_params_with_edited_at)
          if post.save
            render json: post, status: :ok, include: ['tags']
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
        post = current_user.posts.find_by(slug: params[:slug])

        if post.present?
          if post.destroy
            render json: nil, status: :ok, account_user: current_account_user
          else
            render json: post, account_user: current_account_user,
                   status: :unprocessable_entity,
                   serializer: ActiveModel::Serializer::ErrorSerializer
          end
        else
          render json: post, account_user: current_account_user,
                 status: :forbidden,
                 serializer: ActiveModel::Serializer::ErrorSerializer
        end
      end

      private

      def create_post_params
        params.require(:data).require(:attributes).permit(:title, :body, :question_id, :tag_list)
      end

      def update_post_params
        params.require(:data).require(:attributes).permit(:id, :title, :body, :question_id, :tag_list, :edited_at)
      end
    end
  end
end
