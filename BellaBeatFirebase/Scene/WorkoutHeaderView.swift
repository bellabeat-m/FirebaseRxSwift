//
//  WorkoutHeaderView.swift
//  BellaBeatFirebase
//
//  Created by Marina Huber on 2/4/21.
//  Copyright © 2021 Marina Huber. All rights reserved.
//

import UIKit

class WorkoutHeaderView: UIView {
    
    private var imageDownloadReceipt: RequestReceipt?
    
    private lazy var roundImageView: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = Constants.imageWidth / 2.0
        image.layer.backgroundColor = UIColor.green.cgColor
        image.clipsToBounds = true
        
        return image
    }()
    private lazy var bottomContainer = UIView()
    
    private lazy var titleLabel: UILabel = {
        let label = self.createLabelWith(textColor: .darkGray, font: UIFont.systemFont(ofSize: 21))
        return label
    }()
    private lazy var subTitleLabel: UILabel = {
        let label = self.createLabelWith(textColor: .darkGray, font: UIFont.systemFont(ofSize: 14))
        return label
    }()
    
    private var deviderView: UIView = {
        let view = UIView(frame: .zero)
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.gray.cgColor
        
        return view
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = self.createLabelWith(textColor: .black, font: UIFont.systemFont(ofSize: 16))
        return label
    }()
    
    private lazy var timeSubtitle: UILabel = {
        let label = self.createLabelWith(textColor: .darkGray, font: UIFont.systemFont(ofSize: 12))
        return label
    }()
    
    private lazy var exerciseLabel: UILabel = {
        let label = self.createLabelWith(textColor: .black, font: UIFont.systemFont(ofSize: 16))
        return label
    }()
    
    private lazy var exerciseSubtitle: UILabel = {
        let label = self.createLabelWith(textColor: .darkGray, font: UIFont.systemFont(ofSize: 12))
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.setupViews()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.backgroundColor = .white
        
        self.titleLabel.text = "Well done"
        self.subTitleLabel.text = "Burppiees very long title here"
        
        self.exerciseLabel.text = "2/14"
        self.exerciseSubtitle.text = "Exercises test"
        
        self.timeLabel.text = "15 min"
        self.timeSubtitle.text = "Active time"
        

        self.addSubview(self.roundImageView)
        self.addSubview(self.titleLabel)
        self.addSubview(self.subTitleLabel)
        self.addSubview(self.bottomContainer)
        self.addSubview(self.deviderView)
        
        let stackSubviewExercise = UIStackView(arrangedSubviews: [self.exerciseLabel, self.exerciseSubtitle])
        stackSubviewExercise.axis = .vertical
        stackSubviewExercise.distribution = .fillProportionally
        stackSubviewExercise.alignment = .center
        stackSubviewExercise.spacing = 5

        let stackSubviewActivity = UIStackView(arrangedSubviews: [self.timeLabel, self.timeSubtitle])
        stackSubviewActivity.axis = .vertical
        stackSubviewActivity.distribution = .fillProportionally
        stackSubviewActivity.alignment = .center
        stackSubviewActivity.spacing = 5
        
        let horizontalStackView = UIStackView(arrangedSubviews: [stackSubviewExercise, stackSubviewActivity])
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.axis = .horizontal
        horizontalStackView.distribution = .fillEqually
        horizontalStackView.alignment = .center
        horizontalStackView.spacing = 5
        
        self.bottomContainer.addSubview(horizontalStackView)
//        self.bottomContainer.addSubview(self.deviderView)
//        self.bottomContainer.bringSubviewToFront(deviderView)
        
        horizontalStackView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.height.equalToSuperview()
            make.top.equalTo(self.bottomContainer.snp.top)
        }

    }
    
    private func setupConstraints() {
        
        self.roundImageView.snp.makeConstraints { (make) in
            make.top.equalTo(Constants.imageTopConstant)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(Constants.imageWidth)
        }
        
        self.titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-40)
            make.top.equalTo(self.roundImageView.snp.bottom).offset(25)
        }
        self.subTitleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-40)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(5)
        }
        
        self.bottomContainer.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(80)
            make.centerX.equalToSuperview()
            make.top.equalTo(self.subTitleLabel.snp.bottom).offset(25)
        }
        self.deviderView.snp.makeConstraints { (make) in
            make.height.equalTo(47)
            make.width.equalTo(1)
            make.centerX.equalToSuperview()
            make.top.equalTo(self.bottomContainer.snp.top).offset(15)
        }
    }
    
    private func createLabelWith(textColor: UIColor, font: UIFont) -> UILabel {
        let label = UILabel(frame: .zero)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 1
        label.textColor = textColor
        label.font = font
        
        return label
    }
    
    private func setupVideoImageView(imagePath: String) {
        
        if let receipt = self.imageDownloadReceipt {
            self.roundImageView.cancelImageDownload(requestReceipt: receipt)
        }
        if let url = NSURL(string: imagePath) {
            self.imageDownloadReceipt = self.roundImageView.setImageWithURL(url: url, shouldCache: false, scaledToSize: self.roundImageView.size, keepAspectRatio: true)
        } else {

            self.roundImageView.image = nil
        }
    }
    
    func setupHeaderData(imageString: String, title: String, subTitle: String) {
        setupVideoImageView(imagePath: imageString)
        
        let title = "Well done!"
        self.titleLabel.text = title
        self.subTitleLabel.text = subTitle
        self.timeLabel.text = ""
        self.exerciseLabel.text = ""
        self.timeSubtitle.text = ""
        self.exerciseSubtitle.text = ""
    }
}

public struct Constants {
    public static let imageWidth: CGFloat = 140.0
    public static let imageTopConstant = 113.0
}
