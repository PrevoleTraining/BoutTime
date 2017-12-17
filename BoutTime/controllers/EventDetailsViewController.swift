//
//  EventDetailsViewController.swift
//  BoutTime
//
//  Created by PrevoleTraining on 15.12.17.
//  Copyright © 2017 PrevoleTraining. All rights reserved.
//

import UIKit
import WebKit

class EventDetailsViewController: UIViewController {

    var url: String?
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load the URL if available
        if let url = url {
            print(url)
            let urlObject = URL(string: url)
            let urlRequest = URLRequest(url: urlObject!)
            webView.load(urlRequest)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Actions
    @IBAction func dismiss() {
        dismiss(animated: true, completion: nil)
    }
}
