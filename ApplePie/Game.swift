//
//  Game.swift
//  ApplePie
//
//  Created by Amerens Geeske Jongsma on 19/04/2018.
//  Copyright © 2018 Amerens Jongsma. All rights reserved.
//  Creating a Game struct


import Foundation

struct Game {
    var word: String
    var incorrectMovesRemaining: Int
    var guessedLetters: [Character]
    
    mutating func playerGuessed(letter: Character) {
        guessedLetters.append(letter)
        if !word.characters.contains(letter) {
            incorrectMovesRemaining -= 1
        }
    }
    // checking whether use input letter is in the to be guessed word
    var formattedWord: String {
        // depicting length of word with _'s and fill in letter if the word contains it.
        var guessedWord = ""
        for letter in word.characters {
            if guessedLetters.contains(letter) {
                guessedWord += "\(letter)"
            } else {
                guessedWord += " _ "
            }
        }
        return guessedWord
    }
}


