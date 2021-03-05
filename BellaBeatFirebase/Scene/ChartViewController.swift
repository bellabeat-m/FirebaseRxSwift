//
//  ChartViewController.swift
//  BellaBeatFirebase
//
//  Created by Marina Huber on 04.03.2021..
//  Copyright © 2021 Marina Huber. All rights reserved.
//

import UIKit
import AAInfographics

public struct HeartRateAggregateItem {
    let max: Int
    let min: Int
    let avg: Int
}

class ChartViewController: UIViewController, AAChartViewDelegate {
    
    private var aaChartView = AAChartView()
    public var chartType: AAChartType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .yellow
        setupChartView()
        configureColumnrangeMixedLineChart()
    }
    
    private func setupChartView() {
        self.aaChartView.scrollEnabled = false
        self.aaChartView.backgroundColor = .brown
        let chartViewWidth  = view.frame.size.width
        let screenHeight = view.frame.size.height - 60
        
        self.aaChartView.frame = CGRect(x: 0,
                                    y: 0,
                                    width: chartViewWidth,
                                    height: screenHeight)
        aaChartView.contentHeight = self.view.frame.size.height - 20
        self.aaChartView.delegate = self
        self.view.addSubview(self.aaChartView)
        
        aaChartView.translatesAutoresizingMaskIntoConstraints = false
        aaChartView.scrollView.contentInsetAdjustmentBehavior = .never

        
    }
    
//    func addChartConstraints() {
//        self.aaChartView.snp.makeConstraints { (make) in
//            make.top.equalToSuperview().offset(20)
//            make.bottom.equalToSuperview().offset(20)
//            make.centerX.centerY.equalToSuperview().offset(-20)
//        }
//    }

 func configureColumnrangeMixedLineChart() {
    let aaChartModel = AAChartModel()
        .colorsTheme(["#EA007B"])
        .chartType(.columnrange)
        .borderRadius(6)
        .yAxisTitle("heartbeat")
        .animationType(.easeInCirc)
        .stacking(.normal)
        .touchEventEnabled(false)
        .dataLabelsEnabled(false)
        .markerSymbolStyle(.normal)

        .series([
            AASeriesElement()

                .name("Heart beat")
                .type(.line)
                .data([
                    [(9.7), 9.4],
                    [(8.7), 6.5],
                    [(3.5), 9.4],
                    [(1.4),19.9],
                    [0.0 ,  22.6],
                    [2.9 ,  29.5],
                    [9.2 ,  30.7],
                    [7.3 ,  26.5],
                    [4.4 ,  18.0],
                    [(-3.1),11.4]
                ])
            ,
            AASeriesElement()
                .name("Daily")
                .allowPointSelect(false)
                .data([-7.0, 6.9, -9.5, 14.5, -18.2, 21.5, 25.2, 26.5, 23.3, 18.3])

        ])
    let aaOptions = AAOptionsConstructor.configureChartOptions(aaChartModel)

           aaOptions.plotOptions?.columnrange?
               .grouping(false)
            .groupPadding(0.003)
    self.aaChartView.aa_drawChartWithChartModel(aaChartModel)
}
    
    func refreshChartWithChartConfiguration() {}

}
