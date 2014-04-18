# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base

  validates :name, :presence => true

  has_many :authored_polls,
  class_name: "Poll",
  foreign_key: :user_id,
  primary_key: :id

  has_many :responses,
  class_name: "Response",
  foreign_key: :user_id,
  primary_key: :id

  def completed_polls
    polls = Poll.all

    completed_polls = []


    polls.each do |poll|
      num_questions = poll.questions.length

      current_responses = Response.joins(:answer_choice => {:question => :poll}).where("polls.id = ?", poll.id).where("responses.user_id = ?", self.id)

      num_responses = current_responses.length

      completed_polls << poll.title if num_responses == num_questions
    end

    completed_polls

  end







  def completed_polls2
    polls = Poll.all
    current_responses = Response.join(:answer_choice => {:question => :poll}).where("responses.user_id = ?", self.id)

    current_responses.each do |response|
      response.answer_choice_id
    end

    polls.each do |poll|
    end

  end

  def uncompleted_polls

  end

end
