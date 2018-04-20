//
//  ViewController.swift
//  ApplePie
//
//  Created by Amerens Jongsma on 19/04/2018.
//  Apps Minor Programmeren UvA, Unit 2
//
//  This app produces the game Hangman (Galgje in Dutch)
//  Copyright © 2018 Amerens Jongsma. All rights reserved.
//

import UIKit

var listOfWords = ["kitkat", "chocolonely", "twix",
"snicker", "Bros", "milka", "ladybug"]
let incorrectMovesAllowed = 7


class ViewController: UIViewController {
    
    // loading the homepage and starting a new round
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // creating an outlet for all letter buttons
    @IBOutlet var letterButtons: [UIButton]!
    
    // connecting all letter buttons to an action
    @IBAction func buttonPressed(_ sender: UIButton) {
        // while a button is pressed, save this letter and perform actions
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateUI()
        updateGameState()
    }
    
    // function to update the state of the game to show how many wins or loses the user has
    func updateGameState() {
        if currentGame.incorrectMovesRemaining == 0 {
            totalLosses += 1
        } else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
        } else {
            updateUI()
        }
    }
    
    
    @IBOutlet weak var treeImageView: UIImageView!
    
    @IBOutlet weak var correctWordLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    


    // defining current game with struct Game
    var currentGame: Game!
    
    // defining a function to be able to enable all buttons again for a new round
    func enableLetterButtons(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
    // initializing total wins and loses and starting new rounds
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    
    // creating new round and make sure a new word has to be guessed
    func newRound() {
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
            // making sure all letters are enabled again for a new round
            enableLetterButtons(true)
            updateUI()
        }
        // if there are no more words remaining in the library, do not enable the letter again
        else {
            enableLetterButtons(false)
        }
    }
    
    // update the visible page by changing the number of wins and loses and change apple tree during round when a wrong letter was pressed
    func updateUI() {
        correctWordLabel.text = currentGame.formattedWord
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }
    
    // Dispose of any resources that can be recreated.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

