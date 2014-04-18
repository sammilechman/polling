# == Schema Information
#
# Table name: responses
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  answer_choice_id :integer
#  created_at       :datetime
#  updated_at       :datetime
#

class Response < ActiveRecord::Base
  validates :user_id, :answer_choice_id, :presence => true
  validate :author_cant_respond_to_own_poll
  validate :respondent_has_not_already_answered_question

  belongs_to :answer_choice,
  class_name: "AnswerChoice",
  foreign_key: :answer_choice_id,
  primary_key: :id

  belongs_to :user,
  class_name: "User",
  foreign_key: :user_id,
  primary_key: :id


  private


  def respondent_has_not_already_answered_question
    e = existing_responses
    unless e.empty? || (e.count == 1 && e.first.id == self.id)
        errors[:base] << "User can't submit multiple responses to same question."
    end
  end

  def existing_responses
    # Heredoc doesn't start until the next line.
    # we create a holder var for our options hash that
    # speicifies arguments in the SQL query.
    holder = { :answer_choice_id => self.answer_choice_id,
         :user_id => self.user_id }
    Response.find_by_sql([<<-SQL, holder])
    SELECT
      r.*
    FROM
      responses r
    JOIN
      answer_choices a
    ON
      r.answer_choice_id = a.id
    WHERE
      r.user_id = :user_id AND a.question_id = (
      SELECT
        answer_choices.question_id
      FROM
        answer_choices
      WHERE
        answer_choices.id = :answer_choice_id)
      SQL
  end


  def author_cant_respond_to_own_poll
    current_poll = Poll.joins(:questions => :answer_choices )
      .where("answer_choices.id = ?", self.answer_choice_id)


      if current_poll.first.user_id == self.user_id
        errors[:base] << "Author can't respond to own poll."
      end

  end


end
