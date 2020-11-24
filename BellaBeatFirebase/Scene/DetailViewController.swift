//
//  DetailViewController.swift
//  BellaBeatFirebase
//
//  Created by Marina Huber on 11/3/20.
//  Copyright © 2020 Marina Huber. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    public var task: ToDoItem?
    private var taskService = FireTaskAPI()

    
    lazy var taskLabel: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        lbl.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        lbl.textColor = .white
        
        view.addSubview(lbl)
        
        return lbl
    }()
    
    lazy var completedLabel: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        lbl.numberOfLines = 0
        
        view.addSubview(lbl)
        
        return lbl
    }()
    
    lazy var completedQuestion: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        lbl.numberOfLines = 0
        lbl.text = "Is your task completed?"
        lbl.textColor = .white
        
        view.addSubview(lbl)
        
        return lbl
    }()
    
    lazy var emojiIconView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
        img.contentMode = .scaleAspectFit
        
        view.addSubview(img)
        
        return img
    }()
    
    
    lazy var trueButton: UIButton = {
      let btn = UIButton(type: .custom)
      btn.layer.cornerRadius = 12
      btn.backgroundColor = .green
      btn.setTitle("👍Done", for: .normal)
      btn.setTitleColor(.black, for: .normal)
      btn.titleLabel?.font = .systemFont(ofSize: 22, weight: .semibold)
      btn.showsTouchWhenHighlighted = true
      btn.addTarget(self, action: #selector(handleComplete(_:)), for: .touchUpInside)
      
      return btn
    }()
    
    lazy var falseButton: UIButton = {
      let btn = UIButton(type: .custom)
      btn.layer.cornerRadius = 12
      btn.backgroundColor = .red
      btn.setTitle("👎Not done", for: .normal)
      btn.setTitleColor(.black, for: .normal)
      btn.titleLabel?.font = .systemFont(ofSize: 22, weight: .semibold)
      btn.showsTouchWhenHighlighted = true
      btn.addTarget(self, action: #selector(handleComplete(_:)), for: .touchUpInside)
      
      return btn
    }()
    
    lazy var buttonsStack: UIStackView = {
      let stackView = UIStackView(arrangedSubviews: [falseButton, trueButton])
      stackView.alignment = .center
      stackView.spacing = 16
      stackView.axis = .horizontal
      stackView.distribution = .fillEqually
      
      view.addSubview(stackView)
      
      return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let task = task else { return }
        taskService.getImage(from: (task.imageURL ?? ""), completion: { (image) in
            self.emojiIconView.image = image
        })
        if !task.completed {
            falseButton.isHidden = true
        }
        emojiIconView.isHidden = true
        buttonsStack.isHidden = false
        completedLabel.isHidden = true
        completedQuestion.isHidden = false
        view.applyGradient(withColors: [.systemIndigo, .systemIndigo, .systemTeal], locations: [CGPoint(x: 0.0, y: 1.0), CGPoint(x: 1.0, y: 0.0)] as? [NSNumber])
        setupConstraints()
        taskLabel.text = "Your task: \(task.name)"
    }
}

// MARK: - Logic
extension DetailViewController {
    @objc func handleComplete(_ sender: UIButton) {
        let doneSelection = sender == trueButton
        let undoneSelection = sender == falseButton
        self.completedQuestion.isHidden = true
        self.emojiIconView.alpha = 0
        self.emojiIconView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                
        if doneSelection {
            showIconViewAnimate()
            self.completedLabel.text = "✔️ completed"
            self.completedLabel.isHidden = false
            self.completedLabel.textColor = .green
            updateComplete()
            
        } else if undoneSelection {
            showIconViewAnimate()
            self.completedLabel.text = "➖ uncompleted"
            self.completedLabel.isHidden = false
            self.completedLabel.textColor = .red
            updateComplete()
            
        }
    }
    
    func showIconViewAnimate() {
        UIView.animate(withDuration: 0.7,
                       delay: 0.0,
                       usingSpringWithDamping: 0.4,
                       initialSpringVelocity: 0.8,
                       options: .curveEaseIn,
                       animations: {
                        self.emojiIconView.alpha = 1
                        self.emojiIconView.transform = .identity
                        self.emojiIconView.isHidden = false
                        self.buttonsStack.isHidden = true
        }, completion: nil)
    }
    
    func updateComplete() {
        guard var task = task else { return }
        task.completed.toggle()
        taskService.updateCheck(for: task)
    }
}
// MARK: - Constraints
extension DetailViewController {
    
    func setupConstraints() {
        
        taskLabel.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.65).labeled("timerWidth")
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.centerX.equalToSuperview().labeled("timerCenterX")
        }
        
        completedLabel.snp.makeConstraints { make in
            make.top.equalTo(taskLabel.snp.bottom).offset(54)
            make.centerX.equalToSuperview()
        }
        
        completedQuestion.snp.makeConstraints { make in
            make.top.equalTo(completedLabel.snp.bottom).offset(-10)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(30)
        }
        
        emojiIconView.snp.makeConstraints { make in
            make.top.equalTo(completedLabel.snp.bottom).offset(20)
            make.left.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(300)
        }
        buttonsStack.snp.makeConstraints { make in
            make.left.right.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.top.equalTo(completedLabel.snp.bottom).offset(22)
            make.height.equalTo(100)
        }
    }
}
