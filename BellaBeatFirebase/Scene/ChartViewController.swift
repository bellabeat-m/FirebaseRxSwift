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
    let max: Int
    let min: Int
    let avg: Int
}

class ChartViewController: UIViewController, AAChartViewDelegate {
    
    private var aaChartView = AAChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray6
        let chartView = ChartView(frame: .zero)
        self.view.addSubview(chartView)
        
       chartView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(100)
            make.width.equalToSuperview().offset(-20)
            make.centerX.equalTo(self.view.snp.centerX)
            make.height.equalTo(400)
        }
    }
    

  //not used
    private func getRandomNumbersArrMinMax(numbers: Int) -> [Int : Int] {
        let randomNumArr = NSMutableArray()
        for _ in 0 ..< numbers {
            
            let min = Int.random(in: -50...100)
            let max = min + Int.random(in: 10...70)
            let avg = (max + min) / 2
            let lineGramphField = HeartRateAggregateItem(max: max, min: min, avg: avg)
            randomNumArr.add(lineGramphField.min)
        }
        return randomNumArr as! [Int: Int]
    }


 func configureColumnrangeMixedLineChart() {
    let aaChartModel = AAChartModel()
        .colorsTheme(["#FFC8DD"])
        .chartType(.columnrange)
        .borderRadius(6)
        .yAxisTitle("heartbeat")
        .animationType(.easeInCirc)
        .stacking(.normal)
        .touchEventEnabled(false)
        .dataLabelsEnabled(false)
        .series([
            AASeriesElement()
                .name("Heart beat")
                .type(.line)
                .color("#EA007B")
                .zIndex(1)
                .data([0.2, 0.8, 5.7, 11.3, 17.0, 22.0, 24.8, 24.1, 20.1, 14.1, 8.6, 2.5])
            ,
            AASeriesElement()
                .name("Daily")
                .allowPointSelect(false)
                .data([
                    [(-9.7), 9.4],
                    [(-8.7), 6.5],
                    [(-3.5), 9.4],
                    [(-1.4),19.9],
                    [0.0 ,  22.6],
                    [2.9 ,  29.5],
                    [9.2 ,  30.7],
                    [7.3 ,  26.5],
                    [4.4 ,  18.0],
                    [(-3.1),11.4],
                    [(-5.2),10.4],
                    [(-9.9),16.8]
                ])
        ])
    let aaOptions = AAOptionsConstructor.configureChartOptions(aaChartModel)

           aaOptions.plotOptions?.columnrange?
               .grouping(false)
            .groupPadding(0.003)
}
    
    func refreshChartWithChartConfiguration() {}

}
