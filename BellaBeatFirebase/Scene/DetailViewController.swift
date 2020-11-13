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
    private var images: [String] = ["IMG_0.png", "IMG_1.png","IMG_2.png","IMG_3.png","IMG_4.png","IMG_5.png","IMG_6.png", "IMG_8.png", "IMG_9.png", "IMG_7.png"]
    
    lazy var lblTask: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        lbl.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        lbl.textColor = .white
        
        view.addSubview(lbl)
        
        return lbl
    }()
    
    lazy var lblCompleted: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        lbl.numberOfLines = 0
        
        view.addSubview(lbl)
        
        return lbl
    }()
    
    lazy var emojiIconView: UIImageView = {
        let img = UIImageView(image: UIImage(named: "\(images.randomItem() ?? "")"))
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
        img.contentMode = .scaleAspectFit
        
        view.addSubview(img)
        
        return img
    }()
    
    
    lazy var btnTrue: UIButton = {
      let btn = UIButton(type: .custom)
      btn.layer.cornerRadius = 12
      btn.backgroundColor = .green
      btn.setTitle("👍True", for: .normal)
      btn.setTitleColor(.black, for: .normal)
      btn.titleLabel?.font = .systemFont(ofSize: 22, weight: .semibold)
      btn.showsTouchWhenHighlighted = true
      //btn.addTarget(self, action: #selector(handleAnswer(_:)), for: .touchUpInside)
      
      return btn
    }()
    
    lazy var btnFalse: UIButton = {
      let btn = UIButton(type: .custom)
      btn.layer.cornerRadius = 12
      btn.backgroundColor = .red
      btn.setTitle("👎False", for: .normal)
      btn.setTitleColor(.black, for: .normal)
      btn.titleLabel?.font = .systemFont(ofSize: 22, weight: .semibold)
      btn.showsTouchWhenHighlighted = true
     // btn.addTarget(self, action: #selector(handleAnswer(_:)), for: .touchUpInside)
      
      return btn
    }()
    
    lazy var svButtons: UIStackView = {
      let stackView = UIStackView(arrangedSubviews: [btnFalse, btnTrue])
      stackView.alignment = .center
      stackView.spacing = 16
      stackView.axis = .horizontal
      stackView.distribution = .fillEqually
      
      view.addSubview(stackView)
      
      return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.applyGradient(withColors: [.systemIndigo, .systemIndigo, .systemTeal], locations: [CGPoint(x: 0.0, y: 1.0), CGPoint(x: 1.0, y: 0.0)] as? [NSNumber])
        setupConstraints()
        lblTask.text = "Your task: \(task?.name ?? "")"
        toggleCheckbox(lblCompleted, isCompleted: task?.completed ?? false)
        emojiIconView.image = UIImage(named: "\(images.randomItem() ?? "")")
        
    }
    
    func toggleCheckbox(_ text: UILabel, isCompleted: Bool) {
        text.text = isCompleted ? "✔️ completed"  : "➖ uncompleted"
        text.textColor = isCompleted ? .green : .red
    }
    
}
