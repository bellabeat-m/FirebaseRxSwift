//
//  SnapkitTestVC.swift
//  BellaBeatFirebase
//
//  Created by Marina Huber on 11/16/20.
//  Copyright © 2020 Marina Huber. All rights reserved.
//

import UIKit
import SnapKit

class SnapkitTestVC: UIViewController {
    
     var images = [UIColor.green, UIColor.blue, UIColor.magenta, UIColor.cyan, UIColor.purple, UIColor.orange, UIColor.yellow, UIColor.red, UIColor.brown]
    
    var collectionView: UICollectionView?
    
    let whiteView = UIView()
    let yellowView = UIView()
    let blueView = UIView()
    let orangeView = UIView()
    let headerView = UIView()
    let containerView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top:0, left: 10, bottom: 0, right: 10)
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView?.dataSource = self
        collectionView?.delegate = self
        view.backgroundColor = .red
        containerView.backgroundColor = .green
        yellowView.backgroundColor = .yellow
        headerView.backgroundColor = .purple
        orangeView.backgroundColor = .orange
        blueView.backgroundColor = .blue
        whiteView.backgroundColor = .white
        
        view.addSubview(headerView)
        headerView.addSubview(collectionView!)
        view.addSubview(containerView)
        view.addSubview(yellowView)
        view.addSubview(orangeView)
        view.addSubview(blueView)
        view.addSubview(whiteView)
        collectionView?.register(CollectionCell.self, forCellWithReuseIdentifier: CollectionCell.identifier)
        setConstraints()
        
    }
    
    func setConstraints()  {
        headerView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(100)
        }
        collectionView?.snp.makeConstraints { (make) in
            make.top.equalTo(headerView.snp.top)
            make.bottom.equalTo(headerView.snp.bottom)
            make.left.equalTo(headerView.snp.left)
            make.right.equalTo(headerView.snp.right)
        }
        containerView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(headerView.snp.bottom).offset(10)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
            make.width.equalTo(view.safeAreaLayoutGuide)
        }
        yellowView.snp.makeConstraints { (make) in
            make.top.equalTo(containerView.snp.top).offset(10)
            make.bottom.equalTo(containerView.snp.top).offset(100)
            make.width.equalTo(containerView.snp.width).offset(-20)
            make.centerX.equalTo(containerView.snp.centerX)
            
        }
        orangeView.snp.makeConstraints { (make) in
            make.top.equalTo(yellowView.snp.bottom).offset(10)
            make.bottom.equalTo(yellowView.snp.bottom).offset(200)
            make.width.equalTo(containerView.snp.width).offset(-20)
            make.centerX.equalTo(containerView.snp.centerX)
            
        }
        blueView.snp.makeConstraints { (make) in
            make.top.equalTo(orangeView.snp.bottom).offset(10)
            make.bottom.equalTo(orangeView.snp.bottom).offset(100)
            make.centerX.equalTo(containerView.snp.centerX)
            make.left.equalTo(containerView.snp.left).offset(10)

        }
        whiteView.snp.makeConstraints { (make) in
            make.top.equalTo(blueView.snp.bottom).offset(10)
            make.bottom.equalTo(blueView.snp.bottom).offset(90)
            make.left.equalTo(containerView.snp.left).offset(10)
            make.right.equalTo(containerView.snp.right).offset(-10)
            
        }
    }
}

extension SnapkitTestVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColectionCell", for: indexPath) as! CollectionCell
        
        cell.backgroundColor = images[indexPath.row]
        return cell
    }
}

extension SnapkitTestVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 80, height: 80)
    }
}
