//
//  AnimationTest.swift
//  BellaBeatFirebase
//
//  Created by Marina Huber on 16.03.2021..
//  Copyright © 2021 Marina Huber. All rights reserved.
//

import UIKit
import SnapKit
//import BellabeatCommon
//import BellabeatModel
//import BellabeatBluetoothApi


class AnimationTest: UIViewController {
    private let measureView = MeasuringHeartRateView()
    
//    init(commonFactory: CommonFactory, leafDeviceService: LeafDeviceService) {
//        self.leafApi = commonFactory.getLeafAPIHelper()
//        self.leafDeviceService = leafDeviceService
//
//        super.init(nibName: nil, bundle: .main)
//    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.measureView)
        view.backgroundColor = .white
        
        self.measureView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(30)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-30)
            make.width.equalToSuperview().offset(-60)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.measureView.transitionFromWaitingToPresentingData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.measureView.layer.cornerRadius = 10
    }
    

    
}
