//
//  ViewController.swift
//  BoutTime
//
//  Created by PrevoleTraining on 12.12.17.
//  Copyright © 2017 PrevoleTraining. All rights reserved.
//

import UIKit

/**
 Main controller
 */
class ViewController: UIViewController {
    /**
     Quick help text labels
     */
    enum QuickHelpText: String {
        case shake = "Shake to complete"
        case eventInfo = "Tap events to learn more"
    }
    
    // Game constants
    let numberOfRounds = 6
    let eventsPerRound = 4
    
    // Timer constants
    let timerDuration = 60
    let timerInterval = 1

    // Event labels presentation settings
    let labelsPadding = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    let labelsFont = UIFont.boldSystemFont(ofSize: 22.0)

    // Engines
    let gameEngine: Gamable
    let soundEngine = SoundEngine()
    
    // Mapping for labels vs events
    var events: [Event] = []
    
    // Helper arrays to access to labels and butotns
    var eventLabels: [UILabel] = []
    var sortingButtons: [UIButton] = []
    
    // Timer
    var progressTimer: Timer?
    var currentTimerProgression = 0
    
    // Colors
    static let wrongColor = UIColor(red: 199/255, green: 64/255, blue: 40/255, alpha: 1)
    static let correctColor = UIColor(red: 30/255, green: 141/255, blue: 61/255, alpha: 1)
    static let labelTextColor = UIColor(red: 0/255, green: 41/255, blue: 75/255, alpha: 1)
    
    // Mapping with UI controls
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
    
    /*
     * The constructor will load and prepare the data from a plist file
     */
    required init?(coder aDecoder: NSCoder) {
        do {
            let array = try PlistConverter.array(fromFile: "events", ofType: "plist")
            let events = try EventCollectionUnarchiver.events(fromArray: array)
            let eventProvider = EventProvider(events: events)
            self.gameEngine = GameEngine(numberOfRounds: numberOfRounds, eventsPerRound: eventsPerRound, eventProvider: eventProvider)
        } catch let error {
            fatalError("\(error)")
        }
        
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Easy way to access the labels
        eventLabels = [ firstEventLabel, secondEventLabel, thirdEventLabel, fourthEventLabel ]
        
        // Easy way to access the buttons
        sortingButtons = [ firstDownButton, secondUpButton, secondDownButton, thirdUpButton, thirdDownButton, fourthUpButton ]
        
        newGame()
        
        // Configure the labels to have a padding
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
        // Evaluate the round when the user shakes is phone
        if motion == .motionShake {
            evaluate()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // When navigating to event details screen, we need to give the URL
        if segue.destination is EventDetailsViewController {
            let destination = segue.destination as! EventDetailsViewController
            
            if sender is UIGestureRecognizer {
                let label = (sender as! UIGestureRecognizer).view as! UILabel
                
                if let eventIndex = eventLabels.index(of: label) {
                    destination.url = events[eventIndex].url
                }
            }
        } else if segue.destination is ScoreViewController { // When navigating to score screen, we need to give the score
            let destination = segue.destination as! ScoreViewController
            destination.score = gameEngine.score()
        }
    }

    // MARK: - Actions
    
    @IBAction func permute(_ sender: UIButton) {
        // Handle the permutation of two events
        switch sender {
        case firstDownButton: permute(first: firstEventLabel, second: secondEventLabel)
        case secondUpButton: permute(first: secondEventLabel, second: firstEventLabel)
        case secondDownButton: permute(first: secondEventLabel, second: thirdEventLabel)
        case thirdUpButton: permute(first: thirdEventLabel, second: secondEventLabel)
        case thirdDownButton: permute(first: thirdEventLabel, second: fourthEventLabel)
        case fourthUpButton: permute(first: fourthEventLabel, second: thirdEventLabel)
        default: fatalError("Permutation is not supported with \(sender)")
        }
    }

    @IBAction func showEvent(_ sender: UITapGestureRecognizer) {
        // Show the event deteils
        if let labelIndex = eventLabels.index(of: sender.view as! UILabel) {
            print(events[labelIndex].url)
        }
    }
    
    @IBAction func next() {
        // Show next round or end the current game
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
    
    /**
     Configure the label with padding and font
     
     - parameter label: The label to configure
     */
    func setupEventLabel(for label: UILabel) {
        label.padding = labelsPadding
        label.font = labelsFont
    }
    
    /**
     Update the label with different attributes.
 
     - parameter label: The label to configure
     - parameter text: The text to set to the label
     - parameter canBeTouched: Enable or disable the user interaction (avoid showing event details during a round for example)
     - parameter bakcgroundColor: The color to apply to the background
     - parameter textColor: The color to apply to the the text
    */
    func updateEventLabelWith(_ label: UILabel, text: String? = nil, canBeTouched: Bool = false,
                              backgroundColor: UIColor = UIColor.white, textColor: UIColor = labelTextColor) {
        
        if let text = text {
            label.text = text
        }
        
        label.isUserInteractionEnabled = canBeTouched
        label.backgroundColor = backgroundColor
        label.textColor = textColor
    }
    
    /**
     Manage the UI to make a round playable
     */
    func prepareRound() {
        // Show the correct quick help
        quickHelpLabel.text = QuickHelpText.shake.rawValue
        
        // Show the timer label
        timerLabel.isHidden = false
        
        // Hide the next round buttons
        successButton.isHidden = true
        failureButton.isHidden = true
        
        // Set new event texts to the labels
        for index in 0..<events.count {
            updateEventLabelWith(eventLabels[index], text: events[index].title, canBeTouched: false)
        }
        
        // Enable the sorting buttons
        for button in sortingButtons {
            button.isEnabled = true
        }
        
        // Reset the timer
        currentTimerProgression = timerDuration
        timerLabel.text = formatSeconds(seconds: currentTimerProgression)
        
        // Start the new timer
        progressTimer = Timer.scheduledTimer(timeInterval: TimeInterval(timerInterval),
                                             target: self,
                                             selector: #selector(ViewController.updateProgress),
                                             userInfo: nil,
                                             repeats: true)
    }
    
    /**
     Update the progress label
     */
    @objc func updateProgress() {
        if  let progressTimer = progressTimer {
            currentTimerProgression -= 1

            // When timer reach 0, invalidate and evaluate the round
            if currentTimerProgression == 0 {
                progressTimer.invalidate()
                evaluate()
            }

           timerLabel.text = formatSeconds(seconds: currentTimerProgression)
        }
    }
    
    // MARK: - Game
    
    /**
     Prepare the view for a new game
     */
    func newGame() {
        events = gameEngine.newGame()
        prepareRound()
    }
    
    /**
     Proceed to the evaluation of the current round. Manage the UI related to the evaluation.
     */
    func evaluate() {
        // Show correct quick help and hide timer label
        quickHelpLabel.text = QuickHelpText.eventInfo.rawValue
        timerLabel.isHidden = true
        
        // Invalidate the timer if the evaluation occur before the timer end
        if let progressTimer = progressTimer, progressTimer.isValid {
            progressTimer.invalidate()
        }

        // Disable the sorting buttons
        for button in sortingButtons {
            button.isEnabled = false
        }
        
        // Check the result to show the correct button for the next round
        if gameEngine.hasNextRound() {
            let result = gameEngine.evaluate()
        
            switch result {
            case .correct:
                soundEngine.playSound(with: .correct)
                successButton.isHidden = false
            case .incorrect:
                soundEngine.playSound(with: .wrong)
                failureButton.isHidden = false
            }
        }
        
        // Retrieve the solution to show it to the user
        let solution = gameEngine.retrieveSolution()
        
        for (index, eventLabel) in eventLabels.enumerated() {
            updateEventLabelWith(eventLabel, canBeTouched: true)
            
            if /*solution[index].isEqual(other: events[index])*/ solution[index] == events[index] {
                updateEventLabelWith(eventLabel, canBeTouched: true, backgroundColor: ViewController.correctColor, textColor: UIColor.white)
            } else {
                updateEventLabelWith(eventLabel, canBeTouched: true, backgroundColor: ViewController.wrongColor, textColor: UIColor.white)
            }
        }
    }
    
    /**
     Prepare the UI for the next round
     */
    func nextRound() {
        events = gameEngine.nextRound()
        prepareRound()
    }
    
    /**
     End the game. The score screen will be show.
     */
    func endGame() {
        performSegue(withIdentifier: "scoreViewSegue", sender: nil)
    }
    
    /**
     Permute two text labels. In fact, it permute two events.
     The permutation will occur between two labels.
     
     - parameter first: The first label
     - parameter second: The second label
     */
    func permute(first firstLabel: UILabel, second secondLabel: UILabel) {
        if let firstIndex = eventLabels.index(of: firstLabel),
            let secondIndex = eventLabels.index(of: secondLabel) {
            
            events = gameEngine.permute(firstEvent: firstIndex, secondEvent: secondIndex)
            
            // Reflect the permutation in the UI
            firstLabel.text = events[firstIndex].title
            secondLabel.text = events[secondIndex].title
        }
    }
    
    // MARK: - Utils
    
    /**
     Format a duration in seconds two a format like: 0:00
     
     - parameter seconds: The duration to format
     
     - return The formated string
     */
    func formatSeconds(seconds: Int) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = [ .pad ]
        return formatter.string(from: TimeInterval(seconds))!
    }
}

