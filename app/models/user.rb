class User < ApplicationRecord
  has_secure_password
  validates :email, uniqueness: true, presence: true
  validates_email_format_of :email, message: 'is not looking good'

  has_many :user_account_accesses
  has_many :accounts, through: :user_account_accesses
  has_many :posts

  before_create :create_account

  ## Function to build and assign account to the user's instance
  #
  #  @return [nil]
  def create_account
    account = accounts.build
    create_account_user(account)
  end

  ## Function to create instance of AccountUser when a new user is
  #  created
  #
  #  @param [Account] account
  #
  #  @return [AccountUser]

  def create_account_user(account)
    AccountUser.new(user: self, account: account)
  end
end
