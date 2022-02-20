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
        setupUI()
    }
    
    func setupUI() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        if let email = mailTextField.text, let password = passwordTextField.text {
            
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                guard let strongSelf = self else { return }
                
                if let e = error {
                    self!.showError(title: "HATA", message: "\(e.localizedDescription)")
                } else {
                    self!.performSegue(withIdentifier: "loginToMainScreen", sender: self)
                }
            }
        }
    }
}
