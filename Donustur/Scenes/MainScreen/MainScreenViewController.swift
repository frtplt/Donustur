//
//  MainScreenViewController.swift
//  Donustur
//
//  Created by Firat on 19.02.2022.
//

import Foundation
import UIKit
import Firebase

class MainScreenViewController: UIViewController {
    
    @IBOutlet weak var addItemButton: UIButton!
    @IBOutlet weak var personButton: UIButton!
    @IBOutlet weak var navigationButton: UIButton!
    @IBOutlet weak var itemListTableView: UITableView!
    @IBOutlet weak var donusturButtonPressed: UIButton!
    
    var items = ["Strafor","Cam Şişe","Plastik","Bebek Bezi","Pet Şişe","Sakız","Gazete","Mendil","Pil","Plastik Tabak","Alüminyum","İzmarit","Bez Parçası","Kutu Kola","Boyalı Tahta"]
    
    var years = ["2 Milyon Yıl","4000 Yıl","1000 Yıl","550 Yıl","400 Yıl","25 Yıl","3 Ay","2-4 Hafta","300 Yıl","500 Yıl","100 Yıl","2 Yıl","6 Ay","10 Yıl","13 Yıl"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        donusturButtonPressed.isHidden = true
        var email = Auth.auth().currentUser?.email
        if email?.count == nil {
            navigationButton.isHidden = true
            personButton.isHidden = true
            addItemButton.isHidden = true
            donusturButtonPressed.isHidden = false
        }
        itemListTableView.delegate = self
        itemListTableView.dataSource = self
    }
}

extension MainScreenViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        cell.detailTextLabel?.text = years[indexPath.row]
        
        return cell
    }
}




