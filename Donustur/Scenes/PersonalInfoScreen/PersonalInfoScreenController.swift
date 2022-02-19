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
    var personMapInfos = [PersonModelMapInfo]()
    var personScoreInfo = [PersonTotalScore]()
    var totalScore = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
        loadMapInfo()
        loadTotalScore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadItems()
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupUI() {
        
        /*if self.personalInformations[0].eMail.count =! Auth.auth().currentUser?.email?.count {
            DispatchQueue.main.async {
                self.nameLabel.text = "Ad: Ekle Butonuna Basınız"
                self.lastNameLabel.text = "Soyad: Ekle Butonuna Basınız"
                self.birthdayLabel.text = "Doğum Tarihi: Ekle Butonuna Basınız"
                self.mailLabel.text = "E-Mail: Ekle Butonuna Basınız"
                self.phoneNumberLabel.text = "Telefon No: Ekle Butonuna Basınız"
            }*/
        
        DispatchQueue.main.async {
            self.nameLabel.text = "Ad: \(self.personalInformations[0].name)"
            self.lastNameLabel.text = "Soyad: \(self.personalInformations[0].lastName)"
            self.birthdayLabel.text = "Doğum Tarihi: \(self.personalInformations[0].birtdayDate)"
            self.mailLabel.text = "E-Mail: \(self.personalInformations[0].eMail)"
            self.phoneNumberLabel.text = "Telefon No: \(self.personalInformations[0].phoneNumber)"
        }
    }
    
    func setup() {
        self.locationLabel.text = "Adres: Latitude: \(self.personMapInfos[0].locationLatitude), Longitude: \(self.personMapInfos[0].locationLongitude)"
    }
    
    func setupScoreLabel() {
        totalScore = 0.0
        for i in 0..<personScoreInfo.count {
            
            totalScore += self.personScoreInfo[i].totalScore
            
            self.totalScoreLabel.text = "Toplam Puan: \(totalScore)"
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
                        self.personalInformations.insert(newItem, at: 0)
                        self.setupUI()
                    }
                }
            }
        }
    }
    
    func loadTotalScore() {
        
        db.collection("Items")
            .order(by: "ItemDate")
            .addSnapshotListener { (querySnapshot, error) in
                
                self.personScoreInfo = []
                
                if let e = error {
                    print("There was an issue retrieving data from Firestore. \(e)")
                } else {
                    if let snapshotDocuments = querySnapshot?.documents {
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            let personTotalScore = data["ItemScore"]
                            
                            let newItem = PersonTotalScore(totalScore: personTotalScore as? Double ?? 0.0)
                            self.personScoreInfo.append(newItem)
                            self.setupScoreLabel()
                            
                        }
                    }
                }
            }
    }
    
    func loadMapInfo() {
        
        db.collection("MapInformations").addSnapshotListener { (querySnapshot, error) in
            
            self.personMapInfos = []
            
            if let e = error {
                print("There was an issue retrieving data from Firestore. \(e)")
            } else {
                if let snapshotDocuments = querySnapshot?.documents {
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        let personLocationLatitude = data["ItemLatitude"]
                        let personLocationLongitude = data["ItemLongitude"]
                        let newItem = PersonModelMapInfo(locationLatitude: personLocationLatitude as? Double ?? 0.0, locationLongitude: personLocationLongitude as? Double ?? 0.0)
                        self.personMapInfos.append(newItem)
                        self.setup()
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
