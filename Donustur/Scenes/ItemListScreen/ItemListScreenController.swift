//
//  AddItemScreenController.swift
//  Donustur
//
//  Created by Firat on 19.02.2022.
//

import Foundation
import UIKit
import Firebase

class ItemListScreenController: UIViewController {
    
    @IBOutlet weak var itemListTableView: UITableView!
    
    var ıtemModel = [ItemModel]()
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
        setupUI()
    }
    
    func setupUI() {
        itemListTableView.delegate = self
        itemListTableView.dataSource = self
        
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        itemListTableView.register(nib, forCellReuseIdentifier: "TableViewCell")
        
    }
    
    func loadItems() {
        db.collection("Items")
            .order(by: "ItemDate")
            .addSnapshotListener { (querySnapshot, error) in
                
                self.ıtemModel = []
                
                if let e = error {
                    print("There was an issue retrieving data from Firestore. \(e)")
                } else {
                    if let snapshotDocuments = querySnapshot?.documents {
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            let ıtemSender = data["ItemSender"]
                            let ıtemAmount = data["ItemAmount"]
                            let ıtemCategory = data["ItemCategory"]
                            let ıtemDate = data["ItemDate"]
                            let ıtemScore = data["ItemScore"]
                            let newItem = ItemModel(category: ıtemCategory as! String, amount: ıtemAmount as! String, score: ıtemScore as! Double, date: ıtemDate as! String, sender: ıtemSender as! String)
                            self.ıtemModel.append(newItem)
                            
                            DispatchQueue.main.async {
                                self.itemListTableView.reloadData()
                                let indexPath = IndexPath(row: self.ıtemModel.count - 1, section: 0)
                                self.itemListTableView.scrollToRow(at: indexPath, at: .top, animated: false)
                            }
                        }
                    }
                }
            }
    }
}

extension ItemListScreenController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ıtemModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        
        cell.tarihLabel.text = ıtemModel[indexPath.row].date
        cell.puanLabel.text = "Puan: \(ıtemModel[indexPath.row].score)"
        cell.kategoryLabel.text = ıtemModel[indexPath.row].category
        cell.miktarLabel.text = "Miktar: \(ıtemModel[indexPath.row].amount)"
        
        return cell
    }
}



