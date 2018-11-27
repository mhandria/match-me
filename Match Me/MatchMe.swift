//
//  MatchMe.swift
//  Match Me
//
//  Created by Michael Handria on 2/10/18.
//  Copyright © 2018 com.handria.michael. All rights reserved.
//

import Foundation


class MatchMe{
    /*ATRIBUTES*/
    private(set) var cards = [Card]()
    
    private var oneCardFaceUp: Int? {
        get { 
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp{
                    if foundIndex == nil{
                        foundIndex = index
                    }else{
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set{
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    var score: Int = 0
    
    /*INITIALIZER*/
    init(numberOfPairsOfCards: Int){
        assert(numberOfPairsOfCards > 0, "MatchMe.init(\(numberOfPairsOfCards)): less than zero initializer")
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
    
    /*METHODS*/
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
        assert(cards.indices.contains(index), "Concentration.chooseCard(at:\(index)): chosen index not in cards")
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
            }else{
                //either no cards or 2 cards are face up
                oneCardFaceUp = index
            }
        }
    }
}
