//
//  ViewController.swift
//  ChickyLocator
//
//  Created by Jared Williams on 12/11/18.
//  Copyright © 2018 Jared Williams. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    
    
    
    private lazy var label: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        label.text = "⚡️ CHICKY LOCATOR ⚡️"
        label.font = UIFont(name: "futura", size: 30)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var chickyRightView: ChickySelectionView = {
        let view = ChickySelectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), color: UIColor(red: 3/255, green: 155/255, blue: 255/255, alpha: 0.5))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var chickyLeftView: ChickySelectionView = {
        let view = ChickySelectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), color: UIColor(red: 255/255, green: 105/255, blue: 180/255, alpha: 0.5))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var mapButton: UIButton = {
       let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 50, weight: .bold)
        button.setTitle("🐓", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.presentMapController), for: .touchUpInside)
        return button
    }()
    
    private lazy var infoButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 50, weight: .bold)
        button.setTitle("💁🏻‍♂️", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.presentInfoController), for: .touchUpInside)
        return button
    }()
    
    private lazy var rightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "futura", size: 25)
        label.textColor = .white
        label.text = "FIND CHICKY!"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var leftLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "futura", size: 25)
        label.textColor = .white
        label.text = "INFO"
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    func setupView() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.chickyRightView)
        self.view.addSubview(self.chickyLeftView)
        self.view.addSubview(self.mapButton)
        self.view.addSubview(self.infoButton)
        self.view.addSubview(self.rightLabel)
        self.view.addSubview(self.leftLabel)
        self.view.addSubview(self.label)
        
        self.constrainSubViews()
    }
    
    func constrainSubViews() {
        self.chickyRightView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.chickyRightView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.chickyRightView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.chickyRightView.widthAnchor.constraint(equalToConstant: self.view.frame.width / 2 - 2.5).isActive = true
        
        self.chickyLeftView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.chickyLeftView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.chickyLeftView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.chickyLeftView.widthAnchor.constraint(equalToConstant: self.view.frame.width / 2 - 2.5).isActive = true
        
        self.mapButton.centerYAnchor.constraint(equalTo: self.chickyRightView.centerYAnchor).isActive = true
        self.mapButton.centerXAnchor.constraint(equalTo: self.chickyRightView.centerXAnchor).isActive = true
        self.mapButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.infoButton.centerYAnchor.constraint(equalTo: self.chickyLeftView.centerYAnchor).isActive = true
        self.infoButton.centerXAnchor.constraint(equalTo: self.chickyLeftView.centerXAnchor).isActive = true
        self.infoButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.rightLabel.topAnchor.constraint(equalTo: self.mapButton.bottomAnchor, constant: 8).isActive = true
        self.rightLabel.centerXAnchor.constraint(equalTo: self.mapButton.centerXAnchor, constant: 0).isActive = true
        
        self.leftLabel.topAnchor.constraint(equalTo: self.infoButton.bottomAnchor, constant: 8).isActive = true
        self.leftLabel.centerXAnchor.constraint(equalTo: self.infoButton.centerXAnchor, constant: 0).isActive = true
        
        self.label.topAnchor.constraint(equalTo: self.infoButton.bottomAnchor, constant: 80).isActive = true
        self.label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 12).isActive = true
        self.label.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    @objc func presentInfoController() {
        self.present(InfoController(), animated: true, completion: nil)
    }
    
    @objc func presentMapController() {
        self.present(MapController(), animated: true, completion: nil)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

