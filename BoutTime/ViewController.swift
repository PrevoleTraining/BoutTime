//
//  ViewController.swift
//  BoutTime
//
//  Created by lprevost on 12.12.17.
//  Copyright © 2017 prevole.ch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let numberOfRounds = 6
    let eventsPerRound = 4

    let labelsPadding = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    let labelsFont = UIFont.boldSystemFont(ofSize: 22.0)

    let gameEngine: Gamable
    
    @IBOutlet weak var firstEventLabel: UILabel!
    @IBOutlet weak var secondEventLabel: UILabel!
    @IBOutlet weak var thirdEventLabel: UILabel!
    @IBOutlet weak var fourthEventLabel: UILabel!
    
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
        
        setupEventLabel(for: firstEventLabel)
        setupEventLabel(for: secondEventLabel)
        setupEventLabel(for: thirdEventLabel)
        setupEventLabel(for: fourthEventLabel)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Setup UI
    func setupEventLabel(for label: UILabel) {
        label.padding = labelsPadding
        label.font = labelsFont
    }
}

