//
//  Alert+Extension.swift
//  Donustur
//
//  Created by Firat on 19.02.2022.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showError(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "TAMAM", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
}
