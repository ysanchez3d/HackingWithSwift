//
//  ViewController.swift
//  Hangman
//
//  Created by Yandri Sanchez on 12/26/20.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Constants
    let alphabetArray: [[String]] = [
        ["A","B","C","D","E","F","G","H"],
        ["I","J","K","L","M","N","O"],
        ["P","Q","R","S","T","U"],
        ["V","W","X","Y","Z"]
    ]
    
    //MARK: - Variables
    var words = [String]()
    var letterButtons = [UIButton]()
    var tappedLetterButtons = [UIButton]()
    var correctAnswer = ""
    var usedCharacters = Set<String>()
    var currentAnswer: UITextField!
    var triesLeft = 7 {
        didSet {
            title = "Tries left: \(triesLeft)"
        }
    }

    //MARK: - Lifecyle methods
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        currentAnswer = UITextField()
        currentAnswer.translatesAutoresizingMaskIntoConstraints = false
        currentAnswer.textColor = UIColor.systemBlue
        currentAnswer.textAlignment = .center
        currentAnswer.font = UIFont.systemFont(ofSize: 44)
        currentAnswer.isUserInteractionEnabled = false
        currentAnswer.defaultTextAttributes.updateValue(8, forKey: NSAttributedString.Key.kern)
        view.addSubview(currentAnswer)
        
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsView)
        
        var buttonsRow: UIView
        let width = 40
        let height = 50
        
        for (index, row) in alphabetArray.enumerated() {
            buttonsRow = UIView()
            buttonsRow.translatesAutoresizingMaskIntoConstraints = false
            
            for (index, letter) in row.enumerated() {
                let letterButton = UIButton(type: .system)
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 36)
                letterButton.tintColor = .gray
                letterButton.setTitle(letter, for: .normal)
                
                let frame = CGRect(x: index * width, y: 0, width: width, height: height)
                letterButton.frame = frame
                letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
                buttonsRow.addSubview(letterButton)
            }
            
            let rowFrame = CGRect(x: (335 - (row.count * width)) / 2, y: index * height, width: row.count * width, height: height)
            buttonsRow.frame = rowFrame
            buttonsView.addSubview(buttonsRow)
        }
        
        NSLayoutConstraint.activate([
            
            currentAnswer.widthAnchor.constraint(equalToConstant: 365),
            currentAnswer.heightAnchor.constraint(equalToConstant: 70),
            currentAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentAnswer.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 100),
            
            buttonsView.widthAnchor.constraint(equalToConstant: 335),
            buttonsView.heightAnchor.constraint(equalToConstant: 190),
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -80),
        
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        performSelector(inBackground: #selector(loadGame), with: nil)
    }
    
    //MARK: - Actions
    @objc func letterTapped(_ sender: UIButton) {
        guard let tappedLetter = sender.titleLabel?.text else { return }
        sender.isEnabled = false
        tappedLetterButtons.append(sender)
    
        if correctAnswer.contains(tappedLetter) {
            //update UI
            var currentAnswerArray = Array(currentAnswer.text!)
            for (index, letter) in correctAnswer.enumerated() {
                if String(letter) == tappedLetter {
                    currentAnswerArray[index] = letter
                }
            }
            currentAnswer.text = String(currentAnswerArray)
        } else {
            triesLeft -= 1
        }
        
        if currentAnswer.text == correctAnswer {
            let ac = UIAlertController(title: "Dang, You're smart!", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Next Word!", style: .default, handler: { (action) in
                self.nextWord()
            }))
            present(ac, animated: true, completion: nil)
        }
        
        if triesLeft == 0 {
            let ac = UIAlertController(title: "Sorry, you lost!", message: "The correct word was '\(correctAnswer)'. \n Try reading a book to increase your vocabulary.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "I'll read!", style: .default, handler: { (action) in
                self.nextWord()
            }))
            ac.addAction(UIAlertAction(title: "Play again", style: .default, handler: { (action) in
                self.nextWord()
            }))
            present(ac, animated: true, completion: nil)
        }
    }
    
    //MARK: - Public Methods
    @objc func loadGame() {
        if let wordsFileURL = Bundle.main.url(forResource: "words", withExtension: "txt") {
            if let wordsFileContent = try? String(contentsOf: wordsFileURL) {
                words = wordsFileContent.components(separatedBy: "\n")
                words.removeLast()
                words.shuffle()
            }
        }
        
        DispatchQueue.main.async {
            self.nextWord()
        }
    }
    
    func nextWord() {
        triesLeft = 7
        words.removeFirst()
        correctAnswer = words[0].uppercased()
        currentAnswer.text = ""
        for _ in 1...correctAnswer.count {
            currentAnswer.text! += "_"
        }
        
        for btn in tappedLetterButtons {
            btn.isEnabled = true
        }
        tappedLetterButtons.removeAll()
    }
}

