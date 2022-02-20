//
//  RegisterScreenController.swift
//  Donustur
//
//  Created by Firat on 18.02.2022.
//

import Foundation
import UIKit
import Firebase

class RegisterScreenController: UIViewController {
    
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        
        if let email = mailTextField.text, let password = passwordTextField.text {
            
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    self.showError(title: "HATA", message: "\(e.localizedDescription)")
                } else {
                    self.performSegue(withIdentifier: "toMainScreen", sender: self)
                }
            }
        }
    }
}
