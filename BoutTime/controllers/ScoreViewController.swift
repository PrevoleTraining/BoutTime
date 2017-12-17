//
//  ScoreViewController.swift
//  BoutTime
//
//  Created by PrevoleTraining on 15.12.17.
//  Copyright © 2017 PrevoleTraining. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {
    var score: Scorable?
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Format the score if available
        if let score = score {
            scoreLabel.text = "\(score.score) / \(score.scoreMax)"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
