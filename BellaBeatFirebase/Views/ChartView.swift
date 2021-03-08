//
//  ChartView.swift
//  BellaBeatFirebase
//
//  Created by Marina Huber on 08.03.2021..
//  Copyright © 2021 Marina Huber. All rights reserved.
//

import UIKit
import AAInfographics
import SnapKit

class ChartView: UIView {
    
    private var iconView = UIImageView(frame: .zero)
    private var titleLabel = UILabel()
    private var subTitleLabel = UILabel()
    private var aaChartView = AAChartView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        iconView.backgroundColor = .red
        titleLabel.text = "HART RATE"
        subTitleLabel.text = "Average 67 bpm"
        self.layer.cornerRadius = 7
        self.layer.masksToBounds = true
        self.setupViews()
        self.setupConstraints()
        self.configureColumnrangeMixedLineChart()
        self.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupViews() {
        self.setupChartView()
        self.addSubview(iconView)
        self.addSubview(titleLabel)
        self.addSubview(subTitleLabel)
    }
    
    private func setupConstraints() {
        iconView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(15)
            make.height.width.equalTo(40)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(20)
            make.bottom.equalTo(subTitleLabel.snp.top).offset(20)
        }
        subTitleLabel.snp.makeConstraints { (make) in
            make.height.equalTo(20)
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalTo(aaChartView.snp.top).offset(20)
        }
        aaChartView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(80)
            make.width.equalToSuperview().offset(-10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(300)
        }
    }
    
    private func setupChartView() {
        self.aaChartView.scrollEnabled = false
        let chartViewWidth  = self.frame.size.width
        let screenHeight = self.frame.size.height / 3
        
        self.aaChartView.frame = CGRect(x: 0,
                                    y: 120,
                                    width: chartViewWidth,
                                    height: screenHeight)
        self.aaChartView.contentHeight = self.frame.size.height / 3
        self.addSubview(self.aaChartView)
        
        aaChartView.translatesAutoresizingMaskIntoConstraints = false
        aaChartView.scrollView.contentInsetAdjustmentBehavior = .never
    }
    
    private func configureColumnrangeMixedLineChart() {
        let aaChartModel = AAChartModel()
            .colorsTheme(["#FFE5E5"])
            .chartType(.columnrange)
            .borderRadius(6)
            .animationType(.easeInCirc)
            .stacking(.none)
            .legendEnabled(false)
            .touchEventEnabled(false)
            .dataLabelsEnabled(false)
            .tooltipEnabled(false)
            .yAxisLineWidth(0)
            .yAxisGridLineWidth(1)
            .categories(["AM", "", "", "", "" ,"", "", "", "", "", "" ,"", "", "", "", "", "" ,"", "", "", "", "", "PM"])
            .series([
                AASeriesElement()
                    .type(.line)
                    .color("#FF0000")
                    .lineWidth(1.5)
                    .threshold(0)
                    .zIndex(1)
                    .data(getRandomNumbersArrAvg(hours: 24))
                    .marker(AAMarker()
                                .states(AAMarkerStates()
                                            .hover(AAMarkerHover()
                                                    .enabled(false)))
                    )
                ,
                AASeriesElement()
                    .allowPointSelect(false)
                    .zIndex(0)
                    .data([
                        [59.7, 119.4],
                        [(58.7), 116.5],
                        [(53.5), 113.4],
                        [(51.4), 110.9],
                        [50.0 ,  122.6],
                        [52.9 ,  129.5],
                        [59.2 ,  130.7],
                        [57.3 ,  126.5],
                        [54.4 ,  118.0],
                        [(63.1),111.4],
                        [(75.2),110.4],
                        [(79.9),116.8],
                        [(53.5), 113.4],
                        [(51.4), 110.9],
                        [50.0 ,  122.6],
                        [52.9 ,  129.5],
                        [59.2 ,  130.7],
                        [57.3 ,  126.5],
                        [54.4 ,  118.0],
                        [(63.1),111.4],
                        [(75.2),110.4],
                        [(79.9),116.8],
                        [(59.7), 119.4],
                        [(58.7), 116.5]
                    ])
                
            ])
        
        self.aaChartView.aa_drawChartWithChartModel(aaChartModel)
    }
    
    private func getRandomNumbersArrAvg(hours: Int) -> [Int] {
        let randomNumArr = NSMutableArray()
        for _ in 0 ..< hours {
            let min = Int.random(in: 20...100)
            let max = min + Int.random(in: 10...60)
            let avg = (max + min) / 2
            let lineGramphField = HeartRateAggregateItem(max: max, min: min, avg: avg)
            randomNumArr.add(lineGramphField.avg)
        }
        return randomNumArr as! [Int]
    }
}
