//
//  TableViewCell.swift
//  Donustur
//
//  Created by Firat on 19.02.2022.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var puanLabel: UILabel!
    @IBOutlet weak var miktarLabel: UILabel!
    @IBOutlet weak var tarihLabel: UILabel!
    @IBOutlet weak var kategoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
