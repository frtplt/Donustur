//
//  WelcomeScreenBuilder.swift
//  Donustur
//
//  Created by Firat on 18.02.2022.
//

import Foundation
import UIKit

final class WelcomeScreenBuilder {
    static func make() -> UIViewController {
        let storyboard = UIStoryboard(name: "WelcomeScreenStoryboard", bundle: nil)
        
        let navigationViewController = storyboard.instantiateViewController(withIdentifier: "WelcomeScreenController") as! WelcomeScreenController
        return navigationViewController
}
    
}
