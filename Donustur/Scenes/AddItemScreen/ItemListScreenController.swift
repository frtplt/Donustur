//
//  AddItemScreenController.swift
//  Donustur
//
//  Created by Firat on 19.02.2022.
//

import Foundation
import UIKit

class ItemListScreenController: UIViewController {
    
    @IBOutlet weak var itemListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        itemListTableView.delegate = self
        itemListTableView.dataSource = self
        
        let nib = UINib(nibName: "AddItemTableViewCell", bundle: nil)
        itemListTableView.register(nib, forCellReuseIdentifier: "AddItemTableViewCell")
    }
    
}

extension ItemListScreenController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AddItemTableViewCell", for: indexPath) as? AddItemTableViewCell else { fatalError("AddItemTableViewCell not found") }
        
        // Cell bilgilerini gir
        
        return cell
        
    }
    
}



