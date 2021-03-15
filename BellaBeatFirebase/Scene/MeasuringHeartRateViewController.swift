//
// MeasuringHeartRate.swift
// BellabeatApp
//
// Created by Marina Huber on 3/15/21.
// Copyright © 2021 Bellabeat. All rights reserved.
//
import UIKit

class MeasuringHeartRateViewController: UIViewController {
  private var titleHeartRateLabel: UILabel = UILabel(frame: .zero)
  private var imageHeartRate: UIImageView = UIImageView(frame: .zero)
  private var subTitleHeartRateLabel: UILabel = UILabel(frame: .zero)
private var okHeartRateButton: UIButton = UIButton(frame: .zero)

  override func viewDidLoad() {
    super.viewDidLoad()
    self.subTitleHeartRateLabel.adjustsFontSizeToFitWidth = true
    self.subTitleHeartRateLabel.minimumScaleFactor = 0.5
    self.setupViews()
    self.setupConstraints()
    self.onLoad()
    self.view.backgroundColor = .orange
  }
// MARK: - setup methods
  private func loadData() {
  }
    
  private func setupViews() {
    self.view.addSubview(self.titleHeartRateLabel)
    self.view.addSubview(self.imageHeartRate)
    self.view.addSubview(self.subTitleHeartRateLabel)
  }
  private func setupConstraints() {
        self.titleHeartRateLabel.snp.makeConstraints { (make) in
        make.top.bottom.equalToSuperview()
        make.left.right.equalToSuperview()
        make.width.equalToSuperview()
    }
    
    self.imageHeartRate.snp.makeConstraints { (make) in
        make.top.equalToSuperview().offset(20)
        make.width.equalTo(self.view.snp.width).offset(-20)
        make.centerX.equalTo(self.view.snp.centerX)
        make.height.equalTo(330)
    }
    
    self.subTitleHeartRateLabel.snp.makeConstraints { (make) in
        make.top.bottom.equalToSuperview()
        make.left.right.equalToSuperview()
        make.width.equalToSuperview()
    }
    
    self.okHeartRateButton.snp.makeConstraints { (make) in
        make.top.bottom.equalToSuperview()
        make.left.right.equalToSuperview()
        make.width.equalToSuperview()
    }
  }
    
    private func onLoad() {
       self.titleHeartRateLabel.text = "Measuring heart rate"
       self.subTitleHeartRateLabel.text = "Stay still for few seconds"
       UIView.animate(withDuration: 5, animations: {
            self.titleHeartRateLabel.text = "Current heart rate"
            self.subTitleHeartRateLabel.text = "A normal resting heart rate is between 60 and 100 beats per minute (bpm), depending on the person's physical condition and age."
       })
   }
}
