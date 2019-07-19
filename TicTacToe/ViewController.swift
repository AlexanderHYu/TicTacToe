//
//  ViewController.swift
//  TicTacToe
//
//  Created by SESP Walkup on 7/5/19.
//  Copyright © 2019 Alexander Yu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var gridLabel0: GridLabel!
    @IBOutlet weak var gridLabel1: GridLabel!
    @IBOutlet weak var gridLabel2: GridLabel!
    @IBOutlet weak var gridLabel3: GridLabel!
    @IBOutlet weak var gridLabel4: GridLabel!
    @IBOutlet weak var gridLabel5: GridLabel!
    @IBOutlet weak var gridLabel6: GridLabel!
    @IBOutlet weak var gridLabel7: GridLabel!
    @IBOutlet weak var gridLabel8: GridLabel!
    
    var labelsArray = [GridLabel]()
    var xTurn = true
    var gameOver = false
    var counter = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundView.backgroundColor = .blue
        labelsArray = [gridLabel0, gridLabel1, gridLabel2, gridLabel3, gridLabel4, gridLabel5, gridLabel6, gridLabel7, gridLabel8]
    }
    
    func displayWinningMessage(message:String) {
        let alert = UIAlertController(title:message, message: nil, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Reset", style: .default) {
            (action) -> Void in self.resetGame()
        }
        alert.addAction(alertAction)
        present(alert, animated:true, completion: nil)
        print(message)
        gameOver=true
    }
    
    func checkForWinner() {
        // side to side
        checkLine(a:0, b:1,c:2)
        checkLine(a:3, b:4,c:5)
        checkLine(a:6, b:7,c:8)
        // diagonal
        checkLine(a:0, b:4,c:8)
        checkLine(a:2, b:4,c:6)
        // up and down
        checkLine(a:0, b:3,c:6)
        checkLine(a:1, b:4,c:7)
        checkLine(a:2, b:5,c:8)
    }
    
    func checkLine(a: Int, b: Int, c: Int) {
        if labelsArray[a].text != "" && labelsArray[a].text == labelsArray[b].text && labelsArray[b].text == labelsArray[c].text && labelsArray[c].text == labelsArray[a].text {
            if labelsArray[a].text == "X" && labelsArray[b].text == "X" {
                displayWinningMessage(message:"Player using X won!")
                gameOver=true
            }
            else if labelsArray[a].text == "O" && labelsArray[b].text == "O" {
                displayWinningMessage(message:"Player using O won!")
                gameOver=true
            }
        }
    }
    
    func resetGame() {
        for label in labelsArray {
            label.text = ""
            label.canTap = true
        }
        xTurn=true
        gameOver=false
        counter = 0
    }
    
    @IBAction func onTappedGridLabel(_ sender: UITapGestureRecognizer) {
        if gameOver == false {
            counter+=1
            if counter == 9 {
                displayWinningMessage(message:"Cat's game")
            }
            var xAndO = ""
            if xTurn == true{
                xAndO = "X"
                xTurn = false
            }
            else {
                xAndO = "O"
                xTurn = true
            }
            for label in labelsArray {
                if label.canTap {
                    if label.frame.contains(sender.location(in: backgroundView)) {
                        label.text = xAndO
                        label.canTap = false
                    }
                }
            }
        }
        checkForWinner()
    }
}

