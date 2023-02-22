class User < ApplicationRecord
    validates :username, :session_token, presence: true, uniqueness: true
    validates :password_digest, presence: true
    validates :password, length: {minimum: 6}, allow_nil: true
    before_validation :ensure_session_token
    attr_reader :password

    def password=(password)
        self.password_digest = BCrypt::Password.create(password)
        @password = password
    end

    def self.find_by_credentials(username, password)
        user = User.find_by(username: username)
        if user && user.is_password?(password)
            user
        else
            return nil
        end

    end

    def is_password?(password)
        bcrypt_obj = BCrypt::Password.new(self.password_digest)
        bcrypt_obj.is_password?(password)
    end

    def ensure_session_token
        self.session_token ||= generate_session_token
    end

    def generate_session_token
        token = SecureRandom::urlsafe_base64
        if User.exists?(session_token: token)
           token = SecureRandom::urlsafe_base64
        end
        token
    end

    def reset_session_token!
        self.session_token = generate_session_token
        self.save!
        self.session_token
    end
end
