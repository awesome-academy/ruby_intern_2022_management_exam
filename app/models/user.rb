class User < ApplicationRecord
  VALID_EMAIL_REGEX = Settings.user.email_regex
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :records, dependent: :destroy
  has_many :exams, dependent: :destroy
  has_many :results, dependent: :destroy

  enum role: {user: 0, admin: 1}

  before_save :email_downcase

  validates :name, presence: true,
            length: {maximum: Settings.user.name.max_length}

  scope :by_name,
        ->(name){where("name LIKE ?", "%#{name}%") if name.present?}
  scope :by_email,
        ->(email){where("email LIKE ?", "%#{email}%") if email.present?}
  scope :by_created_at,
        (lambda do |start_date, end_date|
          if start_date.present? && end_date.blank?
            by_start_date(start_date)
          elsif start_date.blank? && end_date.present?
            by_end_date(end_date)
          elsif start_date.present? && end_date.present?
            by_between_date(start_date, end_date)
          end
        end)
  scope :by_start_date,
        (lambda do |start_date|
          joins(:exams)
          .where("exams.created_at >= :start_date", start_date: start_date)
        end)
  scope :by_end_date,
        (lambda do |end_date|
          joins(:exams)
          .where("exams.created_at <= :end_date", end_date: end_date)
        end)
  scope :by_between_date,
        (lambda do |start_date, end_date|
          joins(:exams)
          .where("exams.created_at BETWEEN :start_date AND :end_date",
                 start_date: start_date, end_date: end_date)
        end)

  private

  def email_downcase
    email.downcase!
  end
end
