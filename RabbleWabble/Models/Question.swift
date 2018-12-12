//
//  Question.swift
//  RabbleWabble
//
//  Created by Alex Fedoseev on 06.12.2018.
//  Copyright © 2018 Alex Fedoseev. All rights reserved.
//

public class Question: Codable {
    public let answer: String
    public let hint: String?
    public let prompt: String
    
    public init(answer: String, hint: String?, prompt: String) {
        self.answer = answer
        self.hint = hint
        self.prompt = prompt
    }
}
