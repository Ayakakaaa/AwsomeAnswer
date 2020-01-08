class User < ApplicationRecord

    has_many :questions, dependent: :nullify
    has_many :answers, dependent: :nullify

    validates :email, presence: true, uniqueness: true,
    format: /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
    has_secure_password
    # Provides user authentication features on the model
    # it's called in. Requires a column named `password_digest`
    # and the gem `bcrypt`
    # - It will add two attribute accessors for `password`
    #   and `password_confirmation`
    # - It will add a presence validation for the `password`
    #   field.
    # - It will save passwords assigned to `password`
    #   using bcrypt to hash and store it in the
    #   the `password_digest` column meaning that we'll
    #   never store plain text passwords.
    # - It will add a method named `authenticate` to verify
    #   a user's password. If called with the correct password,
    #   it will return the user. Otherwise, it will return `false`
    # - The attr accesssor `password_confirmation` is optional.
    #   If it is present, a validation will verify that it is
    #   identical to the `password` accessor.

    def full_name
        "#{first_name} #{last_name}" 
    end
end
