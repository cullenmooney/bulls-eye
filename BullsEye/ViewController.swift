//
//  ViewController.swift
//  BullsEye
//
//  Created by Cullen Mooney on 2/27/18.
//  Copyright © 2018 Cullen Mooney. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var currentValue = 0
    var targetValue = 0
    var score = 0
    var roundNumber = 0
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var target: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentValue = lroundf(slider.value)
        startNewRound()
    }
    
    func updateLabels() {
        target.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(roundNumber)
    }
    
    func startNewRound() {
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
        roundNumber += 1
        updateLabels()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func sliderMoved(_ slider: UISlider) {
        currentValue = lroundf(slider.value)
    }
    
    
    @IBAction func newGame(_ sender: Any) {
        score = 0
        roundNumber = 0
        startNewRound()
    }
    
    @IBAction func showAlert(_ sender: Any) {
        let difference = abs(targetValue - currentValue)
        var points = 100 - difference
        
        let title : String
        if difference == 0 {
            title = "Perfect score!"
            points += 100
        } else if difference < 5 {
            title = "You almost had it"
            if difference == 1 {
                points += 50
            }
        } else if difference < 10 {
            title = "Good job"
        } else {
            title = "Not even close"
        }
        
        score += points
        
        let message = "You scored \(points) points"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Awesome", style: .default, handler: {
            action in
                self.startNewRound()
        })
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    
}

