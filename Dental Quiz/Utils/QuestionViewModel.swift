//
//  QuestionViewModel.swift
//  Dental Quiz
//
//  Created by Rene Candelier on 12/17/17.
//  Copyright © 2017 Novus Mobile. All rights reserved.
//

import Foundation

struct Question {
    var chapterNumber = ""
    var chapterTitle = ""
    var questionNumber = ""
    var questionTitle = ""
    var answer = ""
    var rationale = ""
    var multipleChoices = [String]()
    var a = ""
    var b = ""
    var c = ""
    var d = ""
    var e = ""
    var f = ""
    var g = ""
    
    enum Answer:String {
        case a = "A. "
        case b = "B. "
        case c = "C. "
        case d = "D. "
        case e = "E. "
        case f = "F. "
        case g = "G. "
        
        init() {
            self = .a
        }
    }
    
    struct Constants {
        static let a = "a"
        static let b = "b"
        static let c = "c"
        static let d = "d"
        static let e = "e"
        static let f = "f"
        static let g = "g"
        static let chapterTitle = "Chapter Title"
        static let chapterNumber = "Chapter Number"
        static let questionNumber = "Question Number"
        static let questionTitle = "Question Title"
        static let answer = "answer"
        static let rationale = "rationale"
    }
}

func parseQuestionsFromPList(plistName: String) -> [Question]? {
    guard let questionsDictionary = getQuestionsFromPlist(plistName: plistName) else { return nil }
    var questions = [Question]()
    questionsDictionary.forEach { (question) in
        var question1 = Question()
        guard let chapterTitle = question[Question.Constants.chapterTitle] as? String,
            let questionTitle = question[Question.Constants.questionTitle] as? String,
            let a = question[Question.Constants.a] as? String,
            let b = question[Question.Constants.b] as? String,
            let c = question[Question.Constants.c] as? String,
            let d = question[Question.Constants.d] as? String,
            let answer = question[Question.Constants.answer] as? String,
            let rationale = question[Question.Constants.rationale] as? String else { return }
        
        if let chapterNumber = question[Question.Constants.chapterNumber] as? String {
            question1.chapterNumber = "\(chapterNumber)"
        }
        if let questionNumber = question[Question.Constants.questionNumber] as? String {
            question1.questionNumber = "\(questionNumber)"
        }
        question1.chapterTitle = chapterTitle
        question1.questionTitle = questionTitle

        question1.a = "A. " + a
        question1.b = "B. " + b
        question1.c = "C. " + c
        question1.d = "D. " + d
        question1.multipleChoices += [question1.a, question1.b, question1.c, question1.d]
        
        if let e = question[Question.Constants.e] as? String, !e.isEmpty {
            question1.e = "E. " + e
            question1.multipleChoices.append(question1.e)
        }
        if let f = question[Question.Constants.f] as? String, !f.isEmpty {
            question1.f = "F. " + f
            question1.multipleChoices.append(question1.f)
        }
        if let g = question[Question.Constants.g] as? String, !g.isEmpty {
            question1.g = "G. " + g
            question1.multipleChoices.append(question1.g)
        }
        question1.answer = answer
        question1.rationale = rationale
        questions.append(question1)
    }
    
    return questions.isEmpty ? nil : questions
}

func getQuestionsFromPlist(plistName: String) -> [[String: Any]]? {
    guard let fileUrl = Bundle.main.url(forResource: plistName, withExtension: "plist"),
        let data = try? Data(contentsOf: fileUrl) else { return nil }
        if let result = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [[String: Any]] {
            guard let result = result else { return nil }
            return result
    }
    return nil
}

func getPDF(pdfFileName: String) -> URL? {
    guard let pdfURL = Bundle.main.url(forResource: pdfFileName, withExtension: "pdf", subdirectory: nil, localization: nil) else { return .none }
    return pdfURL
}
