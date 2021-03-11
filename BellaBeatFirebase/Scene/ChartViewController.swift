//
//  ChartViewController.swift
//  BellaBeatFirebase
//
//  Created by Marina Huber on 04.03.2021..
//  Copyright © 2021 Marina Huber. All rights reserved.
//

import UIKit
import AAInfographics
import SnapKit

public struct HeartRateAggregateItem {
    let max: Int?
    let min: Int?
    let avg: Int?
}

class ChartViewController: UIViewController, AAChartViewDelegate {
    
    private let chartViewDay = ChartView(frame: .zero)
    private let chartViewWeek = ChartViewWeek(frame: .zero)
    private let chartViewMonth = ChartViewMonth(frame: .zero)
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray6
        self.scrollView.showsVerticalScrollIndicator = true
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.contentView)
        self.contentView.addSubview(self.chartViewDay)
        self.contentView.addSubview(self.chartViewWeek)
        self.contentView.addSubview(self.chartViewMonth)
        
        self.scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        self.contentView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        self.chartViewDay.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.width.equalTo(contentView.snp.width).offset(-20)
            make.centerX.equalTo(contentView.snp.centerX)
            make.height.equalTo(330)
        }
        
        self.chartViewWeek.snp.makeConstraints { (make) in
            make.top.equalTo(chartViewDay.snp.bottom).offset(20)
            make.width.equalToSuperview().offset(-20)
            make.centerX.equalTo(contentView.snp.centerX)
            make.height.equalTo(330)
        }
        
        self.chartViewMonth.snp.makeConstraints { (make) in
            make.top.equalTo(chartViewWeek.snp.bottom).offset(20)
            make.centerX.equalTo(contentView.snp.centerX)
            make.height.equalTo(330)
            make.width.equalTo(contentView.snp.width).offset(-20)
            
            make.bottom.equalTo(contentView.snp.bottom)
        }
    }

    func refreshChartWithChartConfiguration() {}

}
