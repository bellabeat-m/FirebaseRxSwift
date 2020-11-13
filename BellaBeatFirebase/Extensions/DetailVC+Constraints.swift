//
//  DetailVC+Constraints.swift
//  BellaBeatFirebase
//
//  Created by Marina Huber on 11/12/20.
//  Copyright © 2020 Marina Huber. All rights reserved.
//

import UIKit
import SnapKit

extension DetailViewController {
    
    func setupConstraints() {
        
        lblTask.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.65).labeled("timerWidth")
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.centerX.equalToSuperview().labeled("timerCenterX")
        }
        
        lblCompleted.snp.makeConstraints { make in
            make.top.equalTo(lblTask.snp.bottom).offset(54)
            make.centerX.equalToSuperview()
        }
        
        emojiIconView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(lblCompleted.snp.bottom).offset(26)
            make.height.equalTo(300)
        }
        svButtons.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.top.equalTo(lblCompleted.snp.bottom).offset(16)
            make.height.equalTo(80)
        }
    }
}
