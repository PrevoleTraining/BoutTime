//
//  ViewController.swift
//  BoutTime
//
//  Created by lprevost on 12.12.17.
//  Copyright © 2017 prevole.ch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    enum QuickHelpText: String {
        case shake = "Shake to complete"
        case eventInfo = "Tap events to learn more"
    }
    
    let numberOfRounds = 2
    let eventsPerRound = 4

    let labelsPadding = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    let labelsFont = UIFont.boldSystemFont(ofSize: 22.0)

    let gameEngine: Gamable
    
    var events: [EventDescriptable] = []
    
    var eventLabels: [UILabel] = []
    
    static let wrongColor = UIColor(red: 199/255, green: 64/255, blue: 40/255, alpha: 1)
    static let correctColor = UIColor(red: 30/255, green: 141/255, blue: 61/255, alpha: 1)
    static let labelTextColor = UIColor(red: 0/255, green: 41/255, blue: 75/255, alpha: 1)
    
    @IBOutlet weak var quickHelpLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var successButton: UIButton!
    @IBOutlet weak var failureButton: UIButton!
    
    @IBOutlet weak var firstEventLabel: UILabel!
    @IBOutlet weak var secondEventLabel: UILabel!
    @IBOutlet weak var thirdEventLabel: UILabel!
    @IBOutlet weak var fourthEventLabel: UILabel!
    
    @IBOutlet weak var firstDownButton: UIButton!
    @IBOutlet weak var secondUpButton: UIButton!
    @IBOutlet weak var secondDownButton: UIButton!
    @IBOutlet weak var thirdUpButton: UIButton!
    @IBOutlet weak var thirdDownButton: UIButton!
    @IBOutlet weak var fourthUpButton: UIButton!
    
    required init?(coder aDecoder: NSCoder) {
        do {
            let array = try PlistConverter.array(fromFile: "events", ofType: "plist")
            let events = try EventCollectionUnarchiver.events(fromArray: array)
            print(events)
            let eventProvider = EventProvider(events: events)
            self.gameEngine = GameEngine(numberOfRounds: numberOfRounds, eventsPerRound: eventsPerRound, eventProvider: eventProvider)
        } catch let error {
            fatalError("\(error)")
        }
        
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventLabels = [ firstEventLabel, secondEventLabel, thirdEventLabel, fourthEventLabel ]
        
        newGame()
        
        for label in eventLabels {
            setupEventLabel(for: label)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func becomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            evaluate()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is EventDetailsViewController {
            let destination = segue.destination as! EventDetailsViewController
            
            if sender is UIGestureRecognizer {
                let label = (sender as! UIGestureRecognizer).view as! UILabel
                
                if let eventIndex = eventLabels.index(of: label) {
                    destination.url = events[eventIndex].url
                }
            }
        } else if segue.destination is ScoreViewController {
            let destination = segue.destination as! ScoreViewController
            destination.score = gameEngine.score()
        }
    }

    // MARK: - Actions
    
    @IBAction func permute(_ sender: UIButton) {
        switch sender {
        case firstDownButton: permute(first: firstEventLabel, second: secondEventLabel)
        case secondUpButton: permute(first: secondEventLabel, second: firstEventLabel)
        case secondDownButton: permute(first: secondEventLabel, second: thirdEventLabel)
        case thirdUpButton: permute(first: thirdEventLabel, second: secondEventLabel)
        case thirdDownButton: permute(first: thirdEventLabel, second: fourthEventLabel)
        case fourthUpButton: permute(first: fourthEventLabel, second: thirdEventLabel)
        default: print("Bad try")
        }
    }

    @IBAction func showEvent(_ sender: UITapGestureRecognizer) {
        if let labelIndex = eventLabels.index(of: sender.view as! UILabel) {
            print(events[labelIndex].url)
        }
    }
    
    @IBAction func next() {
        if gameEngine.hasNextRound() {
            nextRound()
        } else {
            endGame()
        }
    }
    
    @IBAction func startNewGame(segue: UIStoryboardSegue) {
        newGame()
    }
    
    // MARK: - UI
    
    func setupEventLabel(for label: UILabel) {
        label.padding = labelsPadding
        label.font = labelsFont
    }
    
    func updateLabelWith(_ label: UILabel, text: String? = nil, canBeTouched: Bool? = false,
                         backgroundColor: UIColor = UIColor.white, textColor: UIColor = labelTextColor) {
        if let text = text {
            label.text = text
        }
        
        if let canBeTouched = canBeTouched {
            label.isUserInteractionEnabled = canBeTouched
        }
        
        label.backgroundColor = backgroundColor
        label.textColor = textColor
    }
    
    func prepareRound() {
        quickHelpLabel.text = QuickHelpText.shake.rawValue
        timerLabel.isHidden = false
        
        successButton.isHidden = true
        failureButton.isHidden = true
        
       for index in 0..<events.count {
            updateLabelWith(eventLabels[index], text: events[index].title, canBeTouched: false)
        }
    }
    
    // MARK: - Game
    
    func newGame() {
        events = gameEngine.newGame()
        prepareRound()
    }
    
    func evaluate() {
        quickHelpLabel.text = QuickHelpText.eventInfo.rawValue
        timerLabel.isHidden = true

        if gameEngine.hasNextRound() {
            let result = gameEngine.evaluate()
        
            switch result {
            case .correct:
                successButton.isHidden = false
            case .incorrect:
                failureButton.isHidden = false
            }
        }
        
        let solution = gameEngine.retrieveSolution()
        
        for (index, eventLabel) in eventLabels.enumerated() {
            updateLabelWith(eventLabel, canBeTouched: true)
            
            if solution[index].isEqual(other: events[index]) {
                updateLabelWith(eventLabel, backgroundColor: ViewController.correctColor, textColor: UIColor.white)
            } else {
                updateLabelWith(eventLabel, backgroundColor: ViewController.wrongColor, textColor: UIColor.white)
            }
        }
    }
    
    func nextRound() {
        events = gameEngine.nextRound()
        prepareRound()
    }
    
    func endGame() {
        performSegue(withIdentifier: "scoreViewSegue", sender: nil)
    }
    
    func permute(first firstLabel: UILabel, second secondLabel: UILabel) {
        if let firstIndex = eventLabels.index(of: firstLabel),
            let secondIndex = eventLabels.index(of: secondLabel) {
            
            events = gameEngine.permute(firstEvent: firstIndex, secondEvent: secondIndex)
            
            firstLabel.text = events[firstIndex].title
            secondLabel.text = events[secondIndex].title
        }
    }
    
    // MARK: - Delayed
}

