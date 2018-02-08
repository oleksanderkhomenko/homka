class User < ApplicationRecord
  has_many :albums
  has_many :photos
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  validates :first_name, presence: true, format: { with: /\A[a-z]+\z/, message: "should include letters only"}
  validates :last_name, presence: true, format: { with: /\A[a-z]+\z/, message: "should include letters only"}
  validates :user_name, uniqueness: true,
                        format: { with: /\A[a-z0-9](?=.*[a-z])(?:[a-z0-9\-\_])*[a-z0-9]\z/,
                                  message: "can include small letters, numbers, -, _ , start and end with letter and number and have at least 1 letter"},
                        length: { minimum: 5, maximum: 20 },
                        allow_blank: true


  def full_name
    "#{first_name} #{last_name}"
  end
end
