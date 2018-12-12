//
//  RandomQuestionStrategy.swift
//  RabbleWabble
//
//  Created by Alex Fedoseev on 10.12.2018.
//  Copyright © 2018 Alex Fedoseev. All rights reserved.
//

import GameplayKit.GKRandomSource

public class RandomQuestionStrategy: BaseQuestionStrategy {
    public convenience init(
        questionGroupCaretaker: QuestionGroupCaretaker) {
        let questionGroup =
            questionGroupCaretaker.selectedQuestionGroup!
        let randomSource = GKRandomSource.sharedRandom()
        let questions = randomSource.arrayByShufflingObjects(
            in: questionGroup.questions) as! [Question]
        self.init(questionGroupCaretaker: questionGroupCaretaker,questions: questions)
    }
}

