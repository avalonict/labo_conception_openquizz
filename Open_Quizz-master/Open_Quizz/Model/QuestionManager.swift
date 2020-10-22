//
//  QuestionManager.swift
//  Open_Quizz
//
//  Created by Gabriel Larue on 2020-07-01.
//  Copyright © 2020 Gabriel Larue. All rights reserved.
//

import UIKit
import Foundation

class QuestionManager {
    private let url = URL(string: "https://opentdb.com/api.php?amount=10&type=boolean")!
    private let imageUrl = URL(string: "https://source.unsplash.com/random/1000x1000")!
    private var task: URLSessionTask?

    static let shared = QuestionManager()
    private init() {}

    private func getImage(completionHandler: @escaping (Data?) -> Void) {
        let session = URLSession(configuration: .default)
        task?.cancel()
        task = session.dataTask(with: imageUrl) { (data, response, error) in
            DispatchQueue.main.async {
                guard let imageData = data, error == nil else {
                    completionHandler(Data())
                    return
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completionHandler(Data())
                    return
                }
                completionHandler(imageData)
            }
        }
        task?.resume()
    }
    
    func get(callback: @escaping (Bool, NewGameData?) -> ()) {
        task?.cancel()
        task = URLSession.shared.dataTask(with: self.url) { (data, response, error) in
            guard error == nil else {
                callback(false, nil)
                return
            }
            DispatchQueue.main.async {
                let questionData = self.parse(data: data)
                self.getImage{ (data) in
                guard let imageData = data, error == nil else {
                    callback(false, nil)
                    return
                }
                let newGameData = NewGameData(questions: questionData, imageData: imageData)
                    callback(true, newGameData)
                }
                
            }
        }
        task?.resume()
    }

    private func parse(data: Data?) -> [Question] {
        guard let data = data,
            let serializedJson = try? JSONSerialization.jsonObject(with: data, options: []),
            let parsedJson = serializedJson as? [String: Any],
            let results = parsedJson["results"] as? [[String: Any]] else {
                return [Question]()
        }
        return getQuestionsFrom(parsedDatas: results)
    }

    private func getQuestionsFrom(parsedDatas: [[String: Any]]) -> [Question]{
        var retrievedQuestions = [Question]()

        for parsedData in parsedDatas {
            retrievedQuestions.append(getQuestionFrom(parsedData: parsedData))
        }

        return retrievedQuestions
    }

    private func getQuestionFrom(parsedData: [String: Any]) -> Question {
        if let title = parsedData["question"] as? String,
            let answer = parsedData["correct_answer"] as? String {
            return Question(title: String(htmlEncodedString: title)!, isCorrect: (answer == "True"))
        }
        return Question()
    }
}


extension String {

    init?(htmlEncodedString: String) {

        guard let data = htmlEncodedString.data(using: .utf8) else {
            return nil
        }

        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html,
            NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue
        ]

        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return nil
        }

        self.init(attributedString.string)
    }
    
}
