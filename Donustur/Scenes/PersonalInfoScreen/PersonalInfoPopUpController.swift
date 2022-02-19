//
//  PersonalInfoPopUpController.swift
//  Donustur
//
//  Created by Firat on 19.02.2022.
//

import Foundation
import UIKit
import Firebase

class PersonalInfoPopUpController: UIViewController {
    
    let db = Firestore.firestore()
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var addBirtdayDate: UIDatePicker!
    
    var date = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func dateSelectedFromDatePicker (_ : AnyObject) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MMM-yyyy"
            date = dateFormatter.string(from: addBirtdayDate.date)
        }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        
        var personName = nameTextField.text
        var personLastName = lastNameTextField.text
        var personBirtdayDate = date
        var personMail = "\(Auth.auth().currentUser?.email)"
        var personPhoneNumber = phoneNumberTextField.text
        
        db.collection("PersonalInformations").addDocument(data: ["PersonName" : personName,
                                                  "PersonLastName" : personLastName,
                                                  "PersonBirtdayDate" : personBirtdayDate,
                                                  "PersonMail" : personMail,
                                                  "PersonPhoneNumber" : personPhoneNumber
                                                 ]) { error in
            if let e = error {
                self.showError(message: "There was an issue saving Firestore")
            } else {
                print("Succesfully saved")
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
}

        
        
        
        
