//
//  InfoViewController.swift
//  ChickyLocator
//
//  Created by Jared Williams on 12/16/18.
//  Copyright © 2018 Jared Williams. All rights reserved.
//

import Foundation
import UIKit

class InfoController : UIViewController {
    
    private lazy var closeButton: UIButton = {
       let button = UIButton(frame: CGRect(x: 8, y: 8, width: 35, height: 35))
        button.layer.cornerRadius = button.frame.width / 2
        button.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5)
        button.setTitle("X", for: .normal)
        button.titleLabel?.textColor = .white
        button.addTarget(self, action: #selector(self.close), for: .touchUpInside)
        return button
    }()
    
    private lazy var label: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name: "futura", size: 40)
        label.numberOfLines = 4
        label.text = "Made with ❤️\n    By Jared\n      Merry Christmas\n           🎄🎄🎄🎄"
        return label
    }()
    
    override func viewDidLoad() {
        self.setupView()
    }
    
    func setupView() {
        self.view.backgroundColor = .white
        self.view.addSubview(ChickySelectionView(frame: self.view.frame, color: UIColor(red: 255/255, green: 105/255, blue: 180/255, alpha: 0.5)))
        self.view.addSubview(self.closeButton)
        self.view.addSubview(self.label)
        self.constrainSubViews()
    }
    
    func constrainSubViews() {
        self.label.topAnchor.constraint(equalTo: self.closeButton.bottomAnchor, constant: 8).isActive = true
        self.label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.label.heightAnchor.constraint(equalToConstant: 400).isActive = true
        //self.label.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @objc func close() {
        self.dismiss(animated: true, completion: nil)
    }
}
