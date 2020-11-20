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
    
    var collectionView: UICollectionView
    var scrollView = UIScrollView()
    
    let whiteView = UIView.viewWithColorBackground(color: .white)
    let yellowView = UIView.viewWithColorBackground(color: .yellow)
    let blueView = UIView.viewWithColorBackground(color: .blue)
    let orangeView = UIView.viewWithColorBackground(color: .orange)
    let headerView = UIView()
    var contentView = UIView()
    
    init() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top:0, left: 10, bottom: 0, right: 10)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.showsVerticalScrollIndicator = true
        scrollView.backgroundColor = .green
        
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(contentView)
        self.headerView.addSubview(collectionView)
        self.contentView.addSubview(headerView)
        self.contentView.addSubview(yellowView)
        self.contentView.addSubview(orangeView)
        self.contentView.addSubview(blueView)
        self.contentView.addSubview(whiteView)
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.backgroundColor = .white
        
        self.collectionView.register(CollectionCell.self, forCellWithReuseIdentifier: CollectionCell.identifier)
        setConstraints()
        
    }
    
    func setConstraints()  {
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
        headerView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(100)
        }
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(headerView)
        }
        yellowView.snp.makeConstraints { (make) in
            make.top.equalTo(headerView.snp.bottom).offset(10)
            make.centerX.equalTo(contentView.snp.centerX)
            make.height.equalTo(150)
            make.width.equalTo(contentView.snp.width).offset(-40)

        }
        orangeView.snp.makeConstraints { (make) in
            make.top.equalTo(yellowView.snp.bottom).offset(10)
            make.centerX.equalTo(contentView.snp.centerX)
            make.height.equalTo(250)
            make.width.equalTo(contentView.snp.width).offset(-40)
        }
        blueView.snp.makeConstraints { (make) in
            make.top.equalTo(orangeView.snp.bottom).offset(10)
            make.centerX.equalTo(contentView.snp.centerX)
            make.height.equalTo(50)
            make.width.equalTo(contentView.snp.width).offset(-40)
        }
        whiteView.snp.makeConstraints { (make) in
            make.top.equalTo(blueView.snp.bottom).offset(10)
            make.centerX.equalTo(contentView.snp.centerX)
            make.height.equalTo(150)
            make.width.equalTo(contentView.snp.width).offset(-40)
            
            make.bottom.equalTo(contentView.snp.bottom)
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

fileprivate extension UIView {
    static func viewWithColorBackground(color: UIColor) -> UIView {
        let view = UIView()
        view.backgroundColor = color
        return view
    }
}
