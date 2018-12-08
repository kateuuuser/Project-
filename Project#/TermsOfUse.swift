//
//  TermsOfUse.swift
//  Project#
//
//  Created by Юлия on 08.12.2018.
//  Copyright © 2018 Iuliia Grebeshok. All rights reserved.
//

import UIKit

class TermsOfUse: UIViewController {

    @IBOutlet var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        super.viewDidLoad()
        let url = Bundle.main.url(forResource: "tou", withExtension: "html")
        webView.loadRequest(URLRequest(url: url!))
        
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }

    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
