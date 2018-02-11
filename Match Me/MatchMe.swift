//
//  MatchMe.swift
//  Match Me
//
//  Created by Michael Handria on 2/10/18.
//  Copyright © 2018 com.handria.michael. All rights reserved.
//

import Foundation


class MatchMe{
    
    var cards = [Card]()
    var oneCardFaceUp: Int?
    var score: Int = 0
    
    init(numberOfPairsOfCards: Int){
        var deck = [Card]()
        for _ in 1...numberOfPairsOfCards{
            let card = Card()
            deck += [card, card]
        }
        //TODO: shuffle cards
        while(deck.count != 0){
            let randomIndex = Int(arc4random_uniform(UInt32(deck.count)))
            cards.append(deck[randomIndex])
            deck.remove(at: randomIndex)
        }
    }
    
    func getTheme() -> [String]{
        let randTheme = Int(arc4random_uniform(UInt32(3)))
        switch randTheme {
        case 1:
            return ["🐶","🐱","🐭","🐹","🐰", "🦊", "🐻", "🐼", "🐨", "🐯"]
        case 2:
            return ["🍏","🍎","🍐","🍊","🍋", "🍌", "🍉", "🍇", "🍓", "🍈"]
        case 3:
            return ["⚽️","🏀","🏈","⚾️","🎾", "🏐", "🏉", "🎱", "🏓", "🏒"]
        default:
            return ["🐶","🐱","🐭","🐹","🐰", "🦊", "🐻", "🐼", "🐨", "🐯"]
        }
        
    }
    
    func getScore() -> Int{
        return score
    }
    
    func chooseCard(at index: Int){
        if !cards[index].isMatched{
            if let matchIndex = oneCardFaceUp, matchIndex != index{
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                }else{
                    score -= 1
                }
                cards[index].isFaceUp = true
                oneCardFaceUp = nil
            }else{
                //either no cards or 2 cards are face up
                for flipDownIndex in cards.indices{
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                oneCardFaceUp = index
            }
        }
    }
}
