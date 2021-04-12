class User < ApplicationRecord
    has_many :articles, dependent: :destroy
    before_save {
        self.email = self.email.downcase
        self.username = self.username.capitalize
    }
    VALID_EMAIL_REGEX =/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/
    validates :username,
        presence: true,
        length: {minimum: 3, maximum: 25},
        uniqueness: {case_sensitive: false}
    validates :email, 
        presence: true, 
        length: {maximum: 105},
        uniqueness: {case_sensitive: false},
        format: {with: VALID_EMAIL_REGEX}
    has_secure_password
end