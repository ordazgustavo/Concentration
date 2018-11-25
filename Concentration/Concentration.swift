//
//  Concentration.swift
//  Concentration
//
//  Created by Gustavo Ordaz on 11/23/18.
//  Copyright © 2018 Gustavo Ordaz. All rights reserved.
//

import Foundation

class Concentration {
    
    private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    init(numberOfPairOfCards: Int) {
        assert(numberOfPairOfCards > 0, "Concentration.init(\(numberOfPairOfCards): you must have at least one pair of cards")
        for _ in 1...numberOfPairOfCards {
            let card = Card()
            cards += [card, card]
        }
        
        // TODO: Shuffle the cards
        cards.shuffle()
    }
    
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chosenCard(at: \(index): chosen index not in cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    func resetGame() {
        for index in cards.indices {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
        }
        indexOfOneAndOnlyFaceUpCard = nil
        cards.shuffle()
    }
    
}
