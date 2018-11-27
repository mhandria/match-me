//
//  ViewController.swift
//  Match Me
//
//  Created by Michael Handria on 2/10/18.
//  Copyright © 2018 com.handria.michael. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var game = MatchMe(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count+1)/2
    }
    
    private(set) var flipCount = 0{
        didSet{
            scoreLabel.text = "Score: \(game.getScore())"
        }
    }
    
    lazy var emojiChoices = game.getTheme()
    
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }else{
            print("chosen card was not in cardButton")
        }
    }
    
    @IBAction private func newGame(_ sender: UIButton) {
        game = MatchMe(numberOfPairsOfCards: (cardButtons.count+1)/2)
        emojiChoices = self.game.getTheme()
        updateViewFromModel()
        flipCount = 0
    }
    
    private func updateViewFromModel(){
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp{
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else { 
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 0) : #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
            }
        }
    }
    
    //same as doing "var emoji = Dictionary<Int, String>()"
    private var emoji = [Int:String]()
    
    private func emoji(for card: Card) -> String{
        
        
        if emoji[card.identifier] == nil, emojiChoices.count > 0{
            emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        /*  if emoji[card.identifier] != nil{
                 return emoji[card.identifier]!
            } else {
                 return "?"
            }
                 same code as the bottom ...
         */
        return emoji[card.identifier] ?? "?"
    }
}

extension Int {
    var arc4random: Int{
        if self > 0{
            return Int(arc4random_uniform(UInt32(self)))
        }else if self < 0{
            return Int(arc4random_uniform(UInt32(abs(self))))
        }else{
            return 0
        }
    }
}

