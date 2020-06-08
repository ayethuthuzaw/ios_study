//
//  Problem.swift
//  Quiz
//
//  Created by Aye Thu Thu Zaw on 2020/06/08.
//  Copyright © 2020 ALJ. All rights reserved.
//

import UIKit

class Problem: NSObject {
    var question = String()
    var answer = Int()
    
    func setQ(q: String, a: Int) {
        question = q
        answer = a
    }
    
    func getQ() -> String {
        return question
    }

    func getA() -> Int {
        return answer
    }

}
