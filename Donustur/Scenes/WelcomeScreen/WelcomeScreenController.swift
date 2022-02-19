//
//  WelcomeScreenController.swift
//  Donustur
//
//  Created by Firat on 18.02.2022.
//

import Foundation
import UIKit
import Firebase

class WelcomeScreenController: UIViewController {
    
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
        if let email = mailTextField.text, let password = passwordTextField.text {
            
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
          guard let strongSelf = self else { return }
            
            if let e = error {
                self!.showError(message: "\(e.localizedDescription)")
            } else {
                self!.performSegue(withIdentifier: "loginToMainScreen", sender: self)
            }
        }
    }
    }
    
    @IBAction func withoutMemberLogin(_ sender: UIButton) {
    }
}
