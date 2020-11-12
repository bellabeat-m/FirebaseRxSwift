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
      make.width.equalToSuperview().multipliedBy(0.45).labeled("timerWidth")
      make.height.equalTo(45).labeled("timerHeight")
      make.top.equalTo(view.safeAreaLayoutGuide)
      make.centerX.equalToSuperview().labeled("timerCenterX")
    }
    
    lblCompleted.snp.makeConstraints { make in
      make.top.equalTo(lblTask.snp.bottom).offset(34)
      make.leading.equalTo(view.safeAreaLayoutGuide).offset(24)
    }
    
    
    emojiIconView.snp.makeConstraints { make in
      make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
      make.top.equalTo(lblCompleted.snp.bottom).offset(26)
      make.height.equalTo(200)
    }
  }

}
