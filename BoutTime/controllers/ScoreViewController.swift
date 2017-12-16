//
//  ScoreViewController.swift
//  BoutTime
//
//  Created by lprevost on 15.12.17.
//  Copyright © 2017 prevole.ch. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {
    var score: Scorable?
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let score = score {
            scoreLabel.text = "\(score.score) / \(score.scoreMax)"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
