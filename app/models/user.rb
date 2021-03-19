# Field
# email
# password

class User < ApplicationRecord
    has_many :tasks
    has_secure_password

    validates :email, uniqueness: true, presence: true, format: {with: /\A[^@\s]+@[^@\s]+\z/, message: "Must be a valid email address"}
    validates :password_digest, presence: true, length: {minimum: 6}
end
