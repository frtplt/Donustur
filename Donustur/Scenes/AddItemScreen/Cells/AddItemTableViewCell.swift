//
//  AddItemTableViewCell.swift
//  Donustur
//
//  Created by Firat on 19.02.2022.
//

import UIKit

class AddItemTableViewCell: UITableViewCell {

    @IBOutlet var atıkKategoriLabel: UILabel!
    @IBOutlet var atıkTarihLabel: UILabel!
    @IBOutlet var atıkMiktarLabel: UILabel!
    @IBOutlet var atıkPuanLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
