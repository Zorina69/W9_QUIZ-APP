import '../model/question.dart';
import '../model/answer.dart';

final List<QuestionModel> questions = [
  QuestionModel(id: 1, question: "Who is the best teacher?", rightAnswer: "Ronan"),
  QuestionModel(id: 2, question: "What color is the best?", rightAnswer: "Green"),
  QuestionModel(id: 3, question: "Which animal is known as the king of the jungle?", rightAnswer: "Lion"),
  QuestionModel(id: 4, question: "What is the capital city of Cambodia?", rightAnswer: "Phnom Penh"),
  QuestionModel(id: 5, question: "How many days are there in a week?", rightAnswer: "7"),
];


final List<AnswerModel> answers = [
  AnswerModel(id: 1, answers: ["Ronan", "Sopheap", "Dararith"]),
  AnswerModel(id: 2, answers: ["Green", "Red", "Blue"]),
  AnswerModel(id: 3, answers: ["Lion", "Tiger", "Elephant"]),
  AnswerModel(id: 4, answers: ["Phnom Penh", "Siem Reap", "Battambang"]),
  AnswerModel(id: 5, answers: ["7", "5", "10"]),
];
