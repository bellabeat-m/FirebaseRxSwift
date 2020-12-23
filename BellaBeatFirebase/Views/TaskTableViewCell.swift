//
//  TaskCell.swift
//  BellaBeatFirebase
//
//  Created by Marina Huber on 11/13/20.
//  Copyright © 2020 Marina Huber. All rights reserved.
//

import UIKit
import SnapKit

class TaskTableViewCell: UITableViewCell {
    
    static let identifier = "ItemCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.layer.backgroundColor = UIColor.white.cgColor
        setupLayOut()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    lazy var lblTask: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        lbl.font = UIFont.systemFont(ofSize: 19, weight: .light)
        lbl.textColor = .black
        
        return lbl
    }()
    
    
    lazy var lblComplete: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        lbl.textColor = .black
        lbl.numberOfLines = 0
        
        return lbl
    }()
    
}

private extension TaskTableViewCell {
    
    func setupLayOut() {
        contentView.addSubview(lblTask)
        contentView.addSubview(lblComplete)
        
        lblTask.snp.makeConstraints { make in
            make.leading.trailing.equalTo(contentView.safeAreaLayoutGuide).offset(4)
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(6)
            make.bottom.equalTo(lblComplete.snp.top)
        }
        
        lblComplete.snp.makeConstraints { make in
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(8)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(8)
        }
    }
}
