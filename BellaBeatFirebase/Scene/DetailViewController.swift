//
//  DetailViewController.swift
//  BellaBeatFirebase
//
//  Created by Marina Huber on 11/3/20.
//  Copyright © 2020 Marina Huber. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    lazy var lblTask: UILabel = {
      let lbl = UILabel(frame: .zero)
      lbl.layer.cornerRadius = 8
      lbl.layer.borderColor = UIColor.black.cgColor
      lbl.layer.borderWidth = 2
      lbl.textAlignment = .center
      lbl.font = UIFont.systemFont(ofSize: 20, weight: .light)
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
    
    lazy var emojiIcon: UIImageView = {
        let img = UIImageView(image: UIImage(named: "IMG_2"))
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
        img.contentMode = .scaleAspectFit

      return img
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
    }

}
