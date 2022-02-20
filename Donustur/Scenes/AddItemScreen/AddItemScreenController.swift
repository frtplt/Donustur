//
//  AddItemScreenController.swift
//  Donustur
//
//  Created by Firat on 19.02.2022.
//

import Foundation
import UIKit
import Firebase

class AddItemScreenController: UIViewController {
    
    @IBOutlet var addItemPickerView: UIPickerView!
    @IBOutlet var addDatePickerView: UIDatePicker!
    @IBOutlet var addItemAmount: UITextField!
    
    let db = Firestore.firestore()
    
    var category = "Kağıt"
    var date = ""
    var categories = ["Kağıt","Pil","Plastik","Yağ","Cam","Tıbbi"]
    var ıtemScore = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction func dateSelectedFromDatePicker (_ : AnyObject) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy"
        date = dateFormatter.string(from: addDatePickerView.date)
    }
    
    func setupUI() {
        addItemPickerView.delegate = self
        addItemPickerView.dataSource = self
    
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func setup() {
        ıtemScore = Double(addItemAmount.text!) ?? 0.0
        if category == "Kağıt" {
            ıtemScore = Double(addItemAmount.text!)! * 10
        } else if category == "Pil" {
            ıtemScore = Double(addItemAmount.text!)! * 2
        } else if category == "Plastik" {
            ıtemScore = Double(addItemAmount.text!)! * 10
        } else if category == "Yağ" {
            ıtemScore = Double(addItemAmount.text!)! * 10
        } else if category == "Cam" {
            ıtemScore = Double(addItemAmount.text!)! * 4
        } else if category == "Tıbbi" {
            ıtemScore = Double(addItemAmount.text!)! * 0.5
        }
    }
    
    @IBAction func addItemButtonPressed(_ sender: UIButton) {
        
        var ıtemAmount = addItemAmount.text
        var ıtemCategory = category
        var ıtemDate = date
        var ıtemSender = "\(Auth.auth().currentUser?.email)"
        setup()
        
        db.collection("Items").addDocument(data: ["ItemAmount" : ıtemAmount,
                                                  "ItemCategory" : ıtemCategory,
                                                  "ItemDate" : ıtemDate,
                                                  "ItemSender" : ıtemSender,
                                                  "ItemScore" : ıtemScore,
                                                  
                                                 ]) { error in
            if let e = error {
                self.showError(title: "HATA", message: "There was an issue saving Firestore")
            } else {
                print("Succesfully saved")
            }
        }
        showError(title: "Eklendi", message: "Dönüşüm talebiniz kaydedildi")
    }
}

extension AddItemScreenController: UIPickerViewDelegate,UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        category = categories[row]
    }
}
