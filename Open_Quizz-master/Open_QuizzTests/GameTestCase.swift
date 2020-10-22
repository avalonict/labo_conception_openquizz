//
//  GameTestCase.swift
//  Open_QuizzTests
//
//  Created by Gabriel Larue on 2020-07-30.
//  Copyright © 2020 Gabriel Larue. All rights reserved.
//

import XCTest
@testable import Open_Quizz

class GameTestCase: XCTestCase {
    
    var game: Game!;
    
    override func setUp() {
        game = Game();
        game.questions = [Question(title: "Question1 Test", isCorrect: true)]
    }
    
    func testGivenGameIsOnGoing_WhenRefreshing_ThenScoreAndIncorrectAnswerShouldBeZeroAndStateShouldBeOver(){
        game.refresh()
        
        print(game.questions)
        
        XCTAssert(game.score == 0)
        XCTAssert(game.incorrectAnswer == 0)
        XCTAssert(game.state == .over)
    }
    
    func testGivenScoreIsZero_WhenGivenAnswerIsCorrectAndGameIsStillOnGoing_ThenScoreShouldIncrementBy1AndStateShouldStayOnGoing(){
        let question2 = Question(title: "Question2 Test", isCorrect: true)
        game.questions.append(question2)
        
        game.answerCurrentQuestion(with: true)
        
        XCTAssert(game.score == 1)
        XCTAssert(game.incorrectAnswer == 0)
        XCTAssert(game.state == .ongoing)
    }
    
    func testGivenScoreIsZero_WhenGivenAnswerIsIncorrect_ThenIncorrectAnswerShouldIncrementBy1(){
        
        game.answerCurrentQuestion(with: false)
        
        XCTAssert(game.score == 0)
        XCTAssert(game.incorrectAnswer == 1)
    }
    
    func testGivenGameIsOnGoing_WhenLastQuestionIsAnswered_ThenGameIsOver(){
        
        game.answerCurrentQuestion(with: true)
        
        XCTAssert(game.state == .over)
    }
    
    func testImageURL() {
        
        let expectation = XCTestExpectation(description: "Images URL")
        
        let url = URL(string: "https://source.unsplash.com/random/1000x1000")!
        let dataTask = URLSession(configuration: .default).dataTask(with: url) { (data, _, _) in
            
            XCTAssertNotNil(data)
            
            expectation.fulfill()
        }
        
        dataTask.resume()
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testOpenDBURL() {
        
        let expectation = XCTestExpectation(description: "Questions URL")
        
        let url = URL(string: "https://opentdb.com/api.php?amount=10&type=boolean")!
        let dataTask = URLSession(configuration: .default).dataTask(with: url) { (data, _, _) in
            
            XCTAssertNotNil(data)
            
            expectation.fulfill()
        }
        
        dataTask.resume()
        
        wait(for: [expectation], timeout: 10.0)
    }
    
}
