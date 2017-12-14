//
//  ViewController.swift
//  BoutTime
//
//  Created by lprevost on 12.12.17.
//  Copyright © 2017 prevole.ch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var firstEventLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        firstEventLabel.padding = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

