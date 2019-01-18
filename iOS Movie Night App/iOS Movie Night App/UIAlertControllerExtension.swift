//
//  UIAlertControllerExtension.swift
//  iOS Movie Night App
//
//  Created by user on 12/6/18.
//  Copyright © 2018 Treehouse Island. All rights reserved.
//

import Foundation
import UIKit


extension UIAlertController {
    func presentInWindow(animated: Bool, completion: (() -> Void)?) {
        guard let rootVC = UIApplication.shared.keyWindow?.rootViewController else { return }
        rootVC.present(self, animated: animated, completion: completion)
        
    }
    
}







