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
        self.view.backgroundColor = .white
        setupChartView()
        configureColumnrangeMixedLineChartFirst()
        configureColumnrangeMixedLineChart()
    }
    
    private func getRandomNumbersArrAvg(numbers: Int) -> [Int] {
        let randomNumArr = NSMutableArray()
        for _ in 0 ..< numbers {
            
            let min = Int.random(in: 50...100)
            let max = min + Int.random(in: 10...70)
            let avg = (max + min) / 2
            let lineGramphField = HeartRateAggregateItem(max: max, min: min, avg: avg)
            randomNumArr.add(lineGramphField.avg)
        }
        return randomNumArr as! [Int]
    }
    
    private func getRandomNumbersArrMinMax(numbers: Int) -> [Int : Int] {
        let randomNumArr = NSMutableArray()
        for _ in 0 ..< numbers {
            
            let min = Int.random(in: 50...100)
            let max = min + Int.random(in: 10...70)
            let avg = (max + min) / 2
            let lineGramphField = HeartRateAggregateItem(max: max, min: min, avg: avg)
            randomNumArr.add(lineGramphField.min)
        }
        return randomNumArr as! [Int: Int]
    }

    private func setupChartView() {
        self.aaChartView.scrollEnabled = false
        let chartViewWidth  = view.frame.size.width
        let screenHeight = view.frame.size.height / 3
        
        self.aaChartView.frame = CGRect(x: 0,
                                    y: 120,
                                    width: chartViewWidth,
                                    height: screenHeight)
        self.aaChartView.contentHeight = self.view.frame.size.height / 3
        self.view.addSubview(self.aaChartView)
        
        aaChartView.translatesAutoresizingMaskIntoConstraints = false
        aaChartView.scrollView.contentInsetAdjustmentBehavior = .never
    }
    
    func configureColumnrangeMixedLineChartFirst() {
       let aaChartModel = AAChartModel()
           .colorsTheme(["#FFE5E5"])
           .chartType(.columnrange)
           .borderRadius(6)
           .yAxisTitle("heartbeat")
           .animationType(.easeInCirc)
           .stacking(.normal)
           .touchEventEnabled(false)
           .dataLabelsEnabled(false)
           .categories(["AM", "", "", "", "" ,"", "", "", "", "", "" ,"", "", "", "", "", "" ,"", "", "", "", "", "PM"])
           .series([
               AASeriesElement()
                   .name("Heart beat")
                   .type(.line)
                   .color("#FF0000")
                   .threshold(0)
                   .zIndex(1)
                   .data(getRandomNumbersArrAvg(numbers: 24))
               ,
               AASeriesElement()
                   .name("Daily")
                   .allowPointSelect(false)
                   .data([
                       [(59.7), 119.4],
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
       let aaOptions = AAOptionsConstructor.configureChartOptions(aaChartModel)

              aaOptions.plotOptions?.columnrange?
                  .grouping(false)
                .dataLabels?.enabled = false
       self.aaChartView.aa_drawChartWithChartModel(aaChartModel)
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
