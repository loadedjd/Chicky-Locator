//
//  ChickSelectionView.swift
//  ChickyLocator
//
//  Created by Jared Williams on 12/16/18.
//  Copyright © 2018 Jared Williams. All rights reserved.
//

import Foundation
import UIKit


class ChickySelectionView : UIView {
    
    private var color: UIColor?
    private var text: String?
    
    convenience init(frame: CGRect, color: UIColor) {
        self.init(frame: frame)
        self.color = color
        self.setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func setupView() {
        self.backgroundColor = self.color
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
