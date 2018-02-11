//
//  Card.swift
//  Match Me
//
//  Created by Michael Handria on 2/10/18.
//  Copyright © 2018 com.handria.michael. All rights reserved.
//

import Foundation

struct Card{
    var isFaceUp = false
    var isMatched = false
    var identifier: Int

    static var identifierFactory = 0
    
    init(){
        self.identifier = Card.getUniqueIdentifier()
    }
    
    static func getUniqueIdentifier() -> Int{
        identifierFactory+=1
        return identifierFactory
    }
    
    
}
