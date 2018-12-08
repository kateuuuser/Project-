//
//  CheckVerificationViewController.swift
//  Project#
//
//  Created by Юлия on 08.12.2018.
//  Copyright © 2018 Iuliia Grebeshok. All rights reserved.
//

import UIKit

class CheckVerificationViewController: UIViewController {

    @IBOutlet var codeField: UITextField!
    @IBOutlet var errorLabel: UILabel!
    
    var countryCode: String?
    var phoneNumber: String?
    var resultMessage: String?
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet var hud: UIActivityIndicatorView!
    
    @IBAction func validateCode(_ sender: Any) {
        self.errorLabel.text = nil // reset
        if let code = codeField.text {
            self.hud.startAnimating()
            VerifyAPI.validateVerificationCode(self.countryCode!, self.phoneNumber!, code) { checked in
                if (checked.success) {
                    self.hud.stopAnimating()
                    self.resultMessage = checked.message
                    self.performSegue(withIdentifier: "checkResultSegue", sender: nil)
                } else {
                    self.hud.stopAnimating()
                    self.errorLabel.text = checked.message
                }
            }
        }
        hud.stopAnimating()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "checkResultSegue",
            let dest = segue.destination as? VerificationResultViewController {
            dest.message = resultMessage
        }
    }
    
    func dismissKeyboard() {
        codeField.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func tap(_ sender: Any) {
        dismissKeyboard()
    }
    
    
}
