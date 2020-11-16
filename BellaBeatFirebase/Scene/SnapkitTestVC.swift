//
//  SnapkitTestVC.swift
//  BellaBeatFirebase
//
//  Created by Marina Huber on 11/16/20.
//  Copyright © 2020 Marina Huber. All rights reserved.
//

import UIKit
import  SnapKit

class SnapkitTestVC: UIViewController {
    
    let whiteView = UIView()
    let yellowView = UIView()
    let blueView = UIView()
    let orangeView = UIView()
    let headerView = UIView()
    let containerView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        containerView.backgroundColor = .green
        yellowView.backgroundColor = .yellow
        headerView.backgroundColor = .purple
        orangeView.backgroundColor = .orange
        blueView.backgroundColor = .blue
        whiteView.backgroundColor = .white
        
        view.addSubview(headerView)
        view.addSubview(containerView)
        view.addSubview(yellowView)
        view.addSubview(orangeView)
        view.addSubview(blueView)
        view.addSubview(whiteView)
        setConstraints()
        
    }
    
    func setConstraints()  {
        headerView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(100)
        }
        containerView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(headerView.snp.bottom).offset(10)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
            make.width.equalTo(headerView.snp.width)
        }
        yellowView.snp.makeConstraints { (make) in
            make.top.equalTo(containerView.snp.top).offset(10)
            make.bottom.equalTo(containerView.snp.centerY)
            make.width.equalTo(containerView.snp.width).offset(-20)
            make.centerX.equalTo(containerView.snp.centerX)
            
        }
        orangeView.snp.makeConstraints { (make) in
            make.top.equalTo(yellowView.snp.bottom)
            make.bottom.equalTo(containerView.snp.bottom).offset(-10)
            make.width.equalTo(containerView.snp.width).offset(-20)
            make.centerX.equalTo(containerView.snp.centerX)
            
        }
        blueView.snp.makeConstraints { (make) in
            make.top.equalTo(yellowView.snp.top)
            make.bottom.equalTo(containerView.snp.centerY)
            make.width.equalTo(containerView.snp.width).multipliedBy(0.5).offset(-10)
            make.left.equalTo(containerView.snp.centerX)
            
        }
        whiteView.snp.makeConstraints { (make) in
            make.top.equalTo(yellowView.snp.bottom)
            make.bottom.equalTo(orangeView.snp.bottom)
            make.width.equalTo(containerView.snp.width).multipliedBy(0.5).offset(-10)
            make.left.equalTo(containerView.snp.centerX)
            
        }
        
    }
}
