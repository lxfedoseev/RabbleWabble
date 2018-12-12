//
//  SequentialQuestionStrategy.swift
//  RabbleWabble
//
//  Created by Alex Fedoseev on 10.12.2018.
//  Copyright © 2018 Alex Fedoseev. All rights reserved.
//

public class SequentialQuestionStrategy: BaseQuestionStrategy {
    public convenience init(
        questionGroupCaretaker: QuestionGroupCaretaker) {
        let questionGroup =
            questionGroupCaretaker.selectedQuestionGroup!
        let questions = questionGroup.questions
        self.init(questionGroupCaretaker: questionGroupCaretaker,questions: questions)
    }
}

