//
//  PersonalInfoScreenController.swift
//  Donustur
//
//  Created by Firat on 19.02.2022.
//

import Foundation
import UIKit
import Firebase

class PersonalInfoScreenController: UIViewController {
    
    let db = Firestore.firestore()
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var mailLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var totalScoreLabel: UILabel!
    
    var personalInformations = [PersonModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
    }
    
    func setupUI() {
        DispatchQueue.main.async {
            self.nameLabel.text = self.personalInformations[0].name
            self.lastNameLabel.text = self.personalInformations[0].lastName
            self.birthdayLabel.text = self.personalInformations[0].birtdayDate
            self.mailLabel.text = self.personalInformations[0].eMail
            self.phoneNumberLabel.text = self.personalInformations[0].phoneNumber
    }
}
    
    func loadItems() {
            
        db.collection("PersonalInformations").addSnapshotListener { (querySnapshot, error) in
                
                self.personalInformations = []
                
                if let e = error {
                    print("There was an issue retrieving data from Firestore. \(e)")
                } else {
                    if let snapshotDocuments = querySnapshot?.documents {
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            let personName = data["PersonName"]
                            let personLastName = data["PersonLastName"]
                            let personBirtdayDate = data["PersonBirtdayDate"]
                            let personMail = data["PersonMail"]
                            let personPhoneNumber = data["PersonPhoneNumber"]
                            let newItem = PersonModel(name: personName as! String, lastName: personLastName as! String, eMail: personMail as! String, birtdayDate: personBirtdayDate as! String, phoneNumber: personPhoneNumber as! String)
                                self.personalInformations.append(newItem)
                                self.setupUI()
                        }
                    }
                }
            }
        }
    
    @IBAction func logOutButtonPressed(_ sender: UIButton) {
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            performSegue(withIdentifier: "logOut", sender: self)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}
