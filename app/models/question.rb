# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  text       :string(255)      not null
#  poll_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Question < ActiveRecord::Base

  validates :text, :poll_id, :presence => true

  belongs_to :poll,
  class_name: "Poll",
  foreign_key: :poll_id,
  primary_key: :id

  has_many :answer_choices,
  class_name: "AnswerChoice",
  foreign_key: :question_id,
  primary_key: :id

  def results
    answers = Question.includes(:answer_choices)
    Hash.new(0).tap do |return_hash|
      answers.each do |answer|
        return_hash[answer.text] += 1
      end
    end
  end

end
