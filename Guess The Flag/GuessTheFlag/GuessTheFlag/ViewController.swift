//
//  ViewController.swift
//  GuessTheFlag
//
//  Created by Yandri Sanchez on 10/23/20.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    
    //MARK: - Properties
    var countries = [String]()
    var score: Int = 0
    var correctAnswer: Int = 0
    var askedQuestions: Int = 0
    
    
    //MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
    }
    
    
    //MARK: - IBActions
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        var alertMessage: String = ""
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong"
            alertMessage = "That's the flag of \(countries[sender.tag].uppercased())."
            score -= 1
        }
        
        let ac = UIAlertController(title: title, message: alertMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        present(ac, animated: true, completion: nil)
        
    }
    
    
    //MARK: - Public Methods
    
    func askQuestion(action: UIAlertAction! = nil) {
        
        if askedQuestions == 10 {
            let ac = UIAlertController(title: "Game Finished", message: "Your final score is \(score).", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(ac, animated: true)
        }
        
        
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        askedQuestions += 1
        
        title = "\(countries[correctAnswer].uppercased()) \t\t\t\t Score: \(score)"
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
    }


}

