# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

johnny_author = User.create!( name: "Johnny" )
hannah_voter = User.create!( name: "Hannah" )
test_poll = Poll.create!( title: "Prop 1", user_id: johnny_author.id )
test_question = Question.create!( text: "How do you feel about it?", poll_id: test_poll.id )
test_question2 = Question.create!( text: "How did you feel about the last question?", poll_id: test_poll.id)
test_answer = AnswerChoice.create!( text: "Pretty good.", question_id: test_question.id )
test_answer2 = AnswerChoice.create!( text: "Pretty good.", question_id: test_question2.id )
test_response = Response.create!( user_id: hannah_voter.id, answer_choice_id: test_answer.id )
# test_response2 = Response.create!( user_id: hannah_voter.id, answer_choice_id: test_answer2.id )