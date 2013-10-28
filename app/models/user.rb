class User < ActiveRecord::Base

	has_many :todos, dependent: :destroy, inverse_of: :user
  attr_accessible :email, :name

	before_save { |user| user.email = email.downcase }
	before_create :create_remember_token

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, 
										format: { with: VALID_EMAIL_REGEX },
										uniqueness: { case_sensitive: false }

	def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

	private

		def create_remember_token
			self.remember_token = User.encrypt(User.new_remember_token)
		end


end
