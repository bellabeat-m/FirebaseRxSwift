//
// MeasuringHeartRate.swift
// BellabeatApp
//
// Created by Marina Huber on 3/15/21.
// Copyright © 2021 Bellabeat. All rights reserved.
//
import UIKit

class MeasuringHeartRateViewController: UIViewController {
    private var titleHeartRateLabel = UILabel(frame: .zero)
    private var imageHeartRate: UIImageView = UIImageView(frame: .zero)
    private var subTitleHeartRateLabel: UILabel = UILabel(frame: .zero)
    private var okHeartRateButton: UIButton = UIButton(frame: .zero)
    private var innerView: UIImageView = UIImageView(frame: .zero)
    private var outerView: UIImageView = UIImageView(frame: .zero)
    private var currentAnimation = 0

  override func viewDidLoad() {
    super.viewDidLoad()

    self.imageHeartRate.image = UIImage(named: "heart-1")
    self.imageHeartRate.contentMode = .scaleAspectFit
    
    self.innerView.image = UIImage(named: "Ellipse-heart")
    self.outerView.image = UIImage(named: "Ellipse-outer")
    self.innerView.contentMode = .scaleAspectFit
    self.outerView.contentMode = .scaleAspectFit
    
    self.titleHeartRateLabel.text = "Measuring heart rate"
    self.titleHeartRateLabel.font = UIFont.systemFont(ofSize: 20)
    self.titleHeartRateLabel.textAlignment = .center
    
    self.subTitleHeartRateLabel.textAlignment = .center
    self.subTitleHeartRateLabel.text = "Stay still for few seconds"
    self.subTitleHeartRateLabel.font = UIFont.systemFont(ofSize: 16)
    self.subTitleHeartRateLabel.adjustsFontSizeToFitWidth = true
    self.subTitleHeartRateLabel.minimumScaleFactor = 0.5
    self.okHeartRateButton.backgroundColor = .black
    self.view.backgroundColor = .white
    self.setupViews()
    self.setupConstraints()
   // self.showAnimateView()
  }

// MARK: - setup methods
  private func loadData() {
  }
    
  private func setupViews() {
    self.view.addSubview(self.titleHeartRateLabel)
    self.view.addSubview(self.okHeartRateButton)
    self.view.addSubview(self.innerView)
    self.view.addSubview(self.outerView)
    self.view.addSubview(self.imageHeartRate)
    self.view.addSubview(self.subTitleHeartRateLabel)
    self.view.addSubview(self.okHeartRateButton)
  }
  private func setupConstraints() {
    self.titleHeartRateLabel.snp.makeConstraints { (make) in
        make.top.equalToSuperview().offset(120)
        make.centerX.equalToSuperview()
        make.width.equalToSuperview().offset(-40)
    }
    
    self.imageHeartRate.snp.makeConstraints { (make) in
        make.top.equalTo(self.titleHeartRateLabel.snp.bottom).offset(70)
        make.centerX.equalTo(self.titleHeartRateLabel.snp.centerX)
        make.height.width.equalTo(40)
    }
    
    self.innerView.snp.makeConstraints { (make) in
        make.center.equalTo(self.imageHeartRate.snp.center)
        make.height.width.equalTo(110)
    }
    
    self.outerView.snp.makeConstraints { (make) in
        make.center.equalTo(self.imageHeartRate.snp.center)
        make.height.width.equalTo(150)
    }
    
    self.subTitleHeartRateLabel.snp.makeConstraints { (make) in
        make.top.equalTo(self.titleHeartRateLabel.snp.bottom).offset(180)
        make.width.equalToSuperview().offset(-30)
        make.centerX.equalTo(self.titleHeartRateLabel.snp.centerX)
    }
    
    self.okHeartRateButton.snp.makeConstraints { (make) in
        make.centerX.equalTo(self.view.safeAreaLayoutGuide.snp.centerX)
        make.width.equalTo(self.view.safeAreaLayoutGuide.snp.width).offset(-30)
        make.height.equalTo(55)
        make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-30)
    }
  }
    private func showAnimateView() {
        UIView.animate(withDuration: 5, delay: 0, options: [], animations: {
            switch self.currentAnimation {
            case 0:
                self.imageHeartRate.transform = CGAffineTransform(scaleX: 2, y: 2)
            case 1:
                self.imageHeartRate.transform = .identity
            case 2:
                self.imageHeartRate.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            case 3:
                self.imageHeartRate.transform = .identity
            default:
                break
            }
            self.titleHeartRateLabel.text = "Current heart rate"
            self.subTitleHeartRateLabel.text = "A normal resting heart rate is between 60 and 100 beats per minute (bpm), depending on the person's physical condition and age."
            self.imageHeartRate.image = UIImage(named: "heart-measure")
        }) { finished in
        
    }
    self.currentAnimation += 1
   }
    
}
