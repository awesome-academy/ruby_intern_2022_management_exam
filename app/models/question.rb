class Question < ApplicationRecord
  QUESTION_PARAMS = [:subject_id,
                     :description,
                     :question_type,
                     options_attributes: [:id,
                                          :question_id,
                                          :status,
                                          :description,
                                          :_destroy]].freeze
  belongs_to :subject
  has_many :options, dependent: :destroy
  has_many :exams_questions, dependent: :destroy
  has_many :exams, through: :exams_questions, dependent: :destroy

  validates :description, presence: true

  accepts_nested_attributes_for :options,
                                reject_if: :all_blank,
                                allow_destroy: true

  delegate :name, to: :subject, prefix: true, allow_nil: true

  enum question_type: {single_choice: 0, multiple_choice: 1}

  scope :sort_by_date, ->{order(created_at: :desc)}

  class << self
    def import file
      spreadsheet = open_spreadsheet(file)
      header = spreadsheet.row(1)
      (2..spreadsheet.last_row).each do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]
        row[:subject_id] = (Subject.find_by name: row["subject"]).id
        row["question type"] = if row["question type"] == "single"
                                 "single_choice"
                               else
                                 "multiple_choice"
                               end
        handel_excel row["options"]
        row[:options_attributes] = @options_attributes
        row.delete "options"
        row.delete "subject"
        row.delete "question type"
        Question.create! row
      end
    end

    def open_spreadsheet file
      case File.extname(file.original_filename)
      when ".csv" then Roo::CSV.new(file.path)
      when ".xls" then Roo::Excel.new(file.path)
      when ".xlsx" then Roo::Excelx.new(file.path)
      else raise "Unknown file type: #{file.original_filename}"
      end
    rescue StandardRecord
      Rails.logger = Logger.new "Unknown file type"
    end

    protected

    def handel_excel row
      @options_attributes = []
      row.split(",").each do |option|
        option_hash = Hash.new
        arr_option = option.split(":")
        option_hash[:description] = arr_option[0]
        option_hash[:status] = arr_option[1]
        @options_attributes.push option_hash
      end
    end
  end
end
