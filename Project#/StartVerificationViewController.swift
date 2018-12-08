//
//  StartVerificationViewController.swift
//  Project#
//
//  Created by Юлия on 08.12.2018.
//  Copyright © 2018 Iuliia Grebeshok. All rights reserved.
//

import UIKit

class StartVerificationViewController: UIViewController {

    @IBOutlet var phoneNumberField: UITextField!
    @IBOutlet var countryCodeField: UITextField!
    @IBOutlet var label: UILabel!
    
    @IBAction func sendVerification(_ sender: Any) {
        if phoneNumberField.text != "" && countryCodeField.text != "" {
            if let phoneNumber = phoneNumberField.text,
                let countryCode = countryCodeField.text {
                VerifyAPI.sendVerificationCode(countryCode, phoneNumber)
            }
        } else {
            label.text = "Please, fill in your phone number"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? CheckVerificationViewController {
            dest.countryCode = countryCodeField.text
            dest.phoneNumber = phoneNumberField.text
        }
    }
    
    func dismissKeyboard() {
        phoneNumberField.resignFirstResponder()
        countryCodeField.resignFirstResponder()
    }
    
    @IBAction func tap(_ sender: Any) {
        dismissKeyboard()
    }
    

}
