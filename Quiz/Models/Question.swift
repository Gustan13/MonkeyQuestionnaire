//
//  Question.swift
//  Quiz
//
//  Created by Gustavo Binder on 01/08/23.
//

import SwiftUI

class Question : Identifiable {
    let question : String
    
    var options : [(String, Bool)]
    
    var id = UUID()
    
    init(question: String, options: [(String, Bool)]) {
        self.question = question
        self.options = options
    }
}
