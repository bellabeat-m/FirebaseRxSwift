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
    
     var images = [UIColor.green, UIColor.blue, UIColor.magenta, UIColor.cyan, UIColor.purple, UIColor.orange, UIColor.yellow, UIColor.red]
    
    var collectionView: UICollectionView?
    var scrollView: UIScrollView?
    
    let whiteView = UIView()
    let yellowView = UIView()
    let blueView = UIView()
    let orangeView = UIView()
    let headerView = UIView()
    var contentView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        scrollView = UIScrollView(frame:  self.view.bounds)
        scrollView?.contentSize = CGSize(width: self.view.bounds.width, height: self.view.bounds.height)
        scrollView?.showsVerticalScrollIndicator = true
        scrollView?.backgroundColor = .green
        
        yellowView.backgroundColor = .yellow
        headerView.backgroundColor = .purple
        orangeView.backgroundColor = .orange
        blueView.backgroundColor = .blue
        whiteView.backgroundColor = .white
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top:0, left: 10, bottom: 0, right: 10)
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        
        self.view.addSubview(self.scrollView!)
        self.scrollView?.addSubview(contentView)
        self.headerView.addSubview(collectionView!)
        self.contentView.addSubview(headerView)
        self.contentView.addSubview(yellowView)
        self.contentView.addSubview(orangeView)
        self.contentView.addSubview(blueView)
        self.contentView.addSubview(whiteView)
        
        self.collectionView?.dataSource = self
        self.collectionView?.delegate = self
        self.collectionView?.backgroundColor = .white
        
        self.collectionView?.register(CollectionCell.self, forCellWithReuseIdentifier: CollectionCell.identifier)
        setConstraints()
        
    }
    
    func setConstraints()  {
        scrollView?.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        contentView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.scrollView!)
            make.left.right.equalTo(self.scrollView!)
            make.width.equalTo(self.view)
            make.height.equalTo(self.scrollView!)

        }
        headerView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top).offset(10)
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
        yellowView.snp.makeConstraints { (make) in
            make.top.equalTo(headerView.snp.bottom).offset(10)
            make.height.equalTo(150)
            make.width.equalTo(contentView.snp.width).offset(-40)
            make.centerX.equalTo(contentView.snp.centerX)

        }
        orangeView.snp.makeConstraints { (make) in
            make.top.equalTo(yellowView.snp.bottom).offset(10)
            make.height.equalTo(250)
            make.width.equalTo(contentView.snp.width).offset(-40)
            make.centerX.equalTo(contentView.snp.centerX)
        }
        blueView.snp.makeConstraints { (make) in
            make.top.equalTo(orangeView.snp.bottom).offset(10)
            make.height.equalTo(50)
            make.width.equalTo(contentView.snp.width).offset(-40)
            make.centerX.equalTo(contentView.snp.centerX)
        }
        whiteView.snp.makeConstraints { (make) in
            make.top.equalTo(blueView.snp.bottom).offset(10)
            make.bottom.equalTo(contentView.snp.bottom)
            make.centerX.equalTo(contentView.snp.centerX)
            make.height.equalTo(150)
            make.width.equalTo(contentView.snp.width).offset(-40)
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
