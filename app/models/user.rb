class User < ApplicationRecord
  before_save :normalize_full_name
  has_many :albums, dependent: :destroy
  has_many :photos, dependent: :destroy
  has_many :idols, :class_name => 'Subscription', :foreign_key => 'follower_id', dependent: :destroy
  has_many :followers, :class_name => 'Subscription', :foreign_key => 'idol_id', dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :recoverable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable

  validates :first_name, presence: true,
                        format: { with: /\A[a-zA-Z]+\z/, message: "should include letters only"},
                        length: { maximum: 15 }
  validates :last_name, presence: true,
                        format: { with: /\A[a-zA-Z]+\z/, message: "should include letters only"},
                        length: { maximum: 15 }
  validates :user_name, uniqueness: true,
                        format: { with: /\A[a-z0-9](?=.*[a-z])(?:[a-z0-9\-\_])*[a-z0-9]\z/,
                                  message: "can include small letters, numbers, -, _ , start and end with letter or number and have at least 1 letter"},
                        length: { minimum: 5, maximum: 20 },
                        allow_blank: true

  scope :search, -> (q) { where("user_name ILIKE ?", "%#{q}%")
                            .or(where("first_name ILIKE ?", "%#{q}%"))
                            .or(where("last_name ILIKE ?", "%#{q}%")) }


  def full_name
    "#{first_name} #{last_name}"
  end

  def normalize_full_name
    self.first_name = first_name.downcase.capitalize
    self.last_name = last_name.downcase.capitalize
  end

  def idol?(idol_id)
    self.idols.where(idol_id: idol_id).count > 0
  end
end
