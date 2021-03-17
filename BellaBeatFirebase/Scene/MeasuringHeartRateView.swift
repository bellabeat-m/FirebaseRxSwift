//
// MeasuringHeartRateView.swift
// BellabeatApp
//
// Created by Marina Huber on 3/16/21.
// Copyright © 2021 Bellabeat. All rights reserved.
//
import UIKit

class MeasuringHeartRateView: UIView {
    private var titleHeartRateLabel = UILabel(frame: .zero)
    private var heartMiddleLabel = UILabel(frame: .zero)
    private var heartRateImage = UIImageView(frame: .zero)
    private var heartInfoImage = UIImageView(frame: .zero)
    private var subTitleHeartRateLabel: UILabel = UILabel(frame: .zero)
    private var okButton = UIButton(frame: .zero)//OnboardingButton()
    private var animatingView = UIView(frame: .zero)
    private var outerCircleLayer = CAShapeLayer()
    private var innerCircleLayer = CAShapeLayer()
    private var timer: Foundation.Timer?
    var listOfNumbers = [Int]()
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .white
        heartMiddleLabel.alpha = 0
        heartMiddleLabel.font = UIFont.systemFont(ofSize: 23)
        heartMiddleLabel.textColor = .white
        
        heartInfoImage.alpha = 0
        heartInfoImage.contentMode = .scaleAspectFit
        animatingView.alpha = 1
        heartRateImage.image = UIImage(named: "heart-1")
        heartRateImage.contentMode = .scaleAspectFit
        
        titleHeartRateLabel.text = "Measuring heart rate"
        titleHeartRateLabel.font = UIFont.systemFont(ofSize: 20)
        titleHeartRateLabel.textAlignment = .center
        titleHeartRateLabel.numberOfLines = 0
        
        subTitleHeartRateLabel.textAlignment = .center
        subTitleHeartRateLabel.text = "Stay still for few seconds"
        self.subTitleHeartRateLabel.numberOfLines = 0
        subTitleHeartRateLabel.font = UIFont.systemFont(ofSize: 16)
        subTitleHeartRateLabel.adjustsFontSizeToFitWidth = true
        subTitleHeartRateLabel.minimumScaleFactor = 0.5
        
        okButton.backgroundColor = .black
        okButton.alpha = 0

        setupViews()
        setupConstraints()
        setOkutton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


// MARK: - setup methods
    
    func startTimer() {
        let randomNumber = Int.random(in: 64...82)
        
        UIView.transition(with: self, duration: 2.5, options: .transitionCrossDissolve, animations: {
            self.heartInfoImage.alpha = 1
            self.heartInfoImage.image = UIImage(named: "heart-measure")
            self.addHeartRate(bpm: randomNumber)
            self.heartMiddleLabel.alpha = 1
            self.animatingView.alpha = 0
            self.okButton.alpha = 1
            self.subTitleHeartRateLabel.text = "A normal resting heart rate is between 60 and 100 beats per minute (bpm), depending on the person's physical condition and age."
            self.titleHeartRateLabel.text = "Current heart rate"
        }, completion: nil)
        
    }
    
    private func addHeartRate(bpm: Int) {
        listOfNumbers.append(bpm)
        if listOfNumbers.count > 30 {
            listOfNumbers.remove(at: 0)
        }
        let sum = listOfNumbers.reduce(0, +)
        let average = sum / listOfNumbers.count
        self.heartMiddleLabel.text = "\(average) bpm"
    }
    
  private func setupViews() {
    self.addSubview(self.titleHeartRateLabel)
    self.addSubview(self.animatingView)
    self.addSubview(self.heartInfoImage)
    self.addSubview(self.heartRateImage)
    self.addSubview(self.subTitleHeartRateLabel)
    self.addSubview(self.heartMiddleLabel)
    self.addSubview(self.okButton)
  }
  private func setupConstraints() {
    self.titleHeartRateLabel.snp.makeConstraints { (make) in
        make.top.equalToSuperview().offset(100)
        make.centerX.equalToSuperview()
        make.width.equalToSuperview().offset(-180)
    }
    
    self.heartRateImage.snp.makeConstraints { (make) in
        make.top.equalTo(self.titleHeartRateLabel.snp.bottom).offset(80)
        make.centerX.equalTo(self.titleHeartRateLabel.snp.centerX)
        make.height.width.equalTo(40)
    }
    self.heartInfoImage.snp.makeConstraints { (make) in
        make.top.equalTo(self.titleHeartRateLabel.snp.bottom).offset(60)
        make.centerX.equalTo(self.titleHeartRateLabel.snp.centerX)
        make.height.width.equalTo(90)
        make.width.equalTo(110)
    }
    
    self.heartMiddleLabel.snp.makeConstraints { (make) in
        make.top.equalTo(self.heartRateImage.snp.top).offset(10)
        make.centerX.equalTo(self.heartRateImage.snp.centerX)
    }
    
    self.animatingView.snp.makeConstraints { (make) in
        make.center.equalTo(self.heartRateImage.snp.center)
        make.height.width.equalTo(150)
    }
    
    self.subTitleHeartRateLabel.snp.makeConstraints { (make) in
        make.top.equalTo(self.heartInfoImage.snp.bottom).offset(70)
        make.width.equalToSuperview().offset(-80)
        make.centerX.equalTo(self.heartInfoImage.snp.centerX)
    }
    
    self.okButton.snp.makeConstraints { (make) in
        make.centerX.equalTo(self.safeAreaLayoutGuide.snp.centerX)
        make.width.equalTo(self.safeAreaLayoutGuide.snp.width).offset(-30)
        make.height.equalTo(55)
        make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-30)
    }
  }
    
    func setOkutton() {
//        self.okButton.mainColor = DeviceSelectAssets.Colors.MainBackgroundColor()
//        self.okButton.invertedColors = true
        self.okButton.layer.cornerRadius = 27
        self.okButton.tintColor = .white
        self.okButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        self.okButton.setTitle("OK", for: .normal)
    }
    private func setUpAnimations() {
            self.animatingView.scaleAnimtation()
            self.heartRateImage.animaterView()

    }
    
    private func removeAnimations() {
        self.animatingView.layer.removeAllAnimations()
        self.animatingView.layer.removeFromSuperlayer()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setUpAnimations()
    }
    
    
}


extension UIView {
    func animaterView() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.7
        pulse.fromValue = 0.95
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = 7
        pulse.initialVelocity = 0.4
        pulse.damping = 1.0
        layer.add(pulse, forKey: "pulsing")
    }
    
    func scaleAnimtation() {
        let outerCircleLayer = CAShapeLayer()
        let innerCircleLayer = CAShapeLayer()
        self.layer.addSublayer(outerCircleLayer)
       // self.layer.addSublayer(innerCircleLayer)

        innerCircleLayer.borderColor = UIColor(hexString: "#FF8BA1").cgColor
        outerCircleLayer.borderColor = UIColor(hexString: "#FF8BA1").cgColor
        innerCircleLayer.borderWidth = 2
        outerCircleLayer.borderWidth = 2
        innerCircleLayer.cornerRadius = 37
        outerCircleLayer.cornerRadius = 70
        innerCircleLayer.fillColor = UIColor.white.cgColor
        outerCircleLayer.fillColor = UIColor.white.cgColor
        
        outerCircleLayer.path = UIBezierPath(ovalIn: self.bounds).cgPath
        outerCircleLayer.frame = self.bounds

        innerCircleLayer.path = UIBezierPath(ovalIn: outerCircleLayer.bounds.applying(CGAffineTransform(scaleX: 0.5, y: 0.5))).cgPath
        innerCircleLayer.frame = CGRect(origin: CGPoint(x: self.bounds.width / 4, y: self.bounds.height / 4), size: innerCircleLayer.path!.boundingBox.size)
        
        let anim = CABasicAnimation(keyPath: "transform.scale")
        anim.fromValue = 1
        anim.toValue =  0.5
        anim.timingFunction = CAMediaTimingFunction(name: .easeIn)
        anim.duration = 0.8
        // 2
        anim.autoreverses = true
        anim.repeatCount = .infinity
        // 3
        outerCircleLayer.add(anim, forKey: nil)
        // 4
        anim.fromValue =  0
        anim.toValue =  1
        innerCircleLayer.add(anim, forKey: nil)
    }
    
    func rotate(angle: CGFloat) {
        let radians = angle / 180.0 * CGFloat.pi
        self.transform = self.transform.rotated(by: radians)
    }
}


extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
