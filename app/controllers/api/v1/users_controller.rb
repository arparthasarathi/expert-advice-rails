module Api
  module V1
    class UsersController < Api::V1::ApiController
      before_action :doorkeeper_authorize!, except: %i[create show]

      def me
        render json: current_user, account_user: current_account_user
      end

      def show
        user = User.find_by(id: params[:id])

        render json: user
      end

      def create
        user = User.new(user_params)

        if user.save
          render json: user
        else
          render json: user, status: :unprocessable_entity,
                 serializer: ActiveModel::Serializer::ErrorSerializer
        end
      end

      def update
        current_user.assign_attributes(user_params.slice(:email))
        render json: current_user, status: :ok, account_user: account_user
      end

      private
      def user_params
        params.require(:data).require(:attributes).permit(:email, :password)
      end
    end
  end
end
