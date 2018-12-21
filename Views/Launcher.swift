//
//  Launcher.swift
//  ChickyLocator
//
//  Created by Jared Williams on 12/17/18.
//  Copyright © 2018 Jared Williams. All rights reserved.
//

import Foundation
import UIKit

class Launcher : UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(red: 3/255, green: 155/255, blue: 255/255, alpha: 0.5)
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        image.image = UIImage(named: "chicken")
        self.addSubview(image)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
