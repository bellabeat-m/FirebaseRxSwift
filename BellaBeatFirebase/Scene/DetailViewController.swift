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
    
    lazy var lblTask: UILabel = {
      let lbl = UILabel(frame: .zero)
      lbl.textAlignment = .center
      lbl.font = UIFont.systemFont(ofSize: 22, weight: .light)
      lbl.text = "Task"
      
      view.addSubview(lbl)
      
      return lbl
    }()
    

    lazy var lblCompleted: UILabel = {
      let lbl = UILabel(frame: .zero)
      lbl.textAlignment = .center
      lbl.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
      lbl.text = "✔️ Completed"
      lbl.numberOfLines = 0
      
      view.addSubview(lbl)
      
      return lbl
    }()
    
    lazy var emojiIconView: UIImageView = {
        let img = UIImageView(image: UIImage(named: "IMG_2.png"))
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
        img.contentMode = .scaleAspectFit
        
        view.addSubview(img)

      return img
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        lblTask.text = task?.name
        lblCompleted.text = "\(task?.completed ?? false)"
        
    }

}
