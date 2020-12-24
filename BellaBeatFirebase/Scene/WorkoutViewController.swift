//
//  WorkoutViewController.swift
//  BellaBeatFirebase
//
//  Created by Marina Huber on 2/4/21.
//  Copyright © 2021 Marina Huber. All rights reserved.
//

import UIKit


class WorkoutViewController: UIViewController {
    
    private var headerView = WorkoutHeaderView()
    
    private lazy var continueButton: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(handleButtonPressed(_:)), for: .touchUpInside)
        button.backgroundColor = .black
        
        return button
    }()
    
    private var endButton: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(handleButtonPressed(_:)), for: .touchUpInside)
        button.backgroundColor = .white
        button.layer.cornerRadius = 55 / 2.0
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        
        return button
    }()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        self.setupViews()
        self.setupConstraints()
    }
    
    private func setupViews() {
        self.view.addSubview(self.headerView)
        self.view.addSubview(self.continueButton)
        self.view.addSubview(self.endButton)
        self.setup(button: continueButton, stringKey: "CONTINUE WORKOUT", colorText: .white)
        self.setup(button: endButton, stringKey: "END WORKOUT", colorText :.black)
    }
    
    private func setupConstraints()  {
        self.headerView.snp.makeConstraints { (make) in
            make.top.left.width.equalToSuperview()
            make.height.equalTo(466)
        }
        
        self.continueButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.endButton.snp.top).offset(-10)
            make.centerX.equalTo(self.view.safeAreaLayoutGuide.snp.centerX)
            make.width.equalToSuperview().offset(-30)
            make.height.equalTo(55)
        }
        
        self.endButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-150)
            make.centerX.equalTo(self.view.safeAreaLayoutGuide.snp.centerX)
            make.width.equalToSuperview().offset(-30)
            make.height.equalTo(55)
        }
    }
    
    @objc func handleButtonPressed(_ sender: UIButton) {
        
    }
    
    private func setup(button: UIButton, stringKey: String, colorText: UIColor) {
        button.setTitle(stringKey, for: .normal)
        button.setTitleColor(colorText, for: .normal)
        //button.titleLabel?.font = AppStyle.Font.Medium12
        button.layer.cornerRadius = 55 / 2.0
        button.layer.masksToBounds = true
    }

}
