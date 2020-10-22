//
//  Game.swift
//  Open_Quizz
//
//  Created by Gabriel Larue on 2020-06-28.
//  Copyright © 2020 Gabriel Larue. All rights reserved.
//

import Foundation

class Game{
    
    enum State{
        case ongoing, over
    }
    
    var score: Int = 0;
    var incorrectAnswer: Int = 0;
    var questions: [Question] = [];
    var state: State = .ongoing;
    var imageData: Data?;
    private var currentIndex: Int = 0;
    var currentQuestion: Question? {
        get {
            guard currentIndex < questions.count else {
                return nil
            }
            return questions[currentIndex];
        }
    };
    
    func answerCurrentQuestion(with answer : Bool){
        if(currentQuestion!.isCorrect == answer){
            score += 1;
        }else{
            incorrectAnswer += 1;
        }
        if(currentIndex < questions.count - 1){
            currentIndex += 1;
        }else{
            state = .over;
        }
    }
    
    func refresh(){
        score = 0;
        incorrectAnswer = 0;
        state = .over;
        currentIndex = 0;
        }
}
    
