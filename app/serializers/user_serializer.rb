class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :account

  def account
    if @instance_options[:account_user]
      account_user = @instance_options[:account_user]
      account_user.account
    end
  end
end
