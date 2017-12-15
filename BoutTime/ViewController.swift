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
    
    let numberOfRounds = 6
    let eventsPerRound = 4

    let labelsPadding = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    let labelsFont = UIFont.boldSystemFont(ofSize: 22.0)

    let gameEngine: Gamable
    
    var events: [EventDescriptable] = []
    
    var eventLabels: [UILabel] = []
    
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
            print("Hey! Take care of me!")
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
    
    // MARK: - UI
    
    func setupEventLabel(for label: UILabel) {
        label.padding = labelsPadding
        label.font = labelsFont
    }
    
    func updateText(for label: UILabel, with text: String) {
        label.text = text
    }
    
    // MARK: - Game
    
    func newGame() {
        quickHelpLabel.text = QuickHelpText.shake.rawValue
        
        events = gameEngine.newGame()
        
        for index in 0..<events.count {
            updateText(for: eventLabels[index], with: events[index].title)
        }
    }
    
    func permute(first firstLabel: UILabel, second secondLabel: UILabel) {
        if let firstIndex = eventLabels.index(of: firstLabel),
            let secondIndex = eventLabels.index(of: secondLabel) {
            gameEngine.permute(firstEvent: firstIndex, secondEvent: secondIndex)
            
            let bubbleText = firstLabel.text
            firstLabel.text = secondLabel.text
            secondLabel.text = bubbleText
        }
    }
}

