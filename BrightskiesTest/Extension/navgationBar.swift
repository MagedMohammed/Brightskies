//
//  navgationBar.swift
//  NovationApp
//
//  Created by Youxel MacBook 8 on 9/1/19.
//  Copyright © 2019 Youxel. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func setColorOfNav(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(named: "lightBlue")]
    }
}
