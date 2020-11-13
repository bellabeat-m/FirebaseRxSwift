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
        let img = UIImageView(image: UIImage(named: "\(images.randomItem() ?? "")"))
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
        img.contentMode = .scaleAspectFit
        
        view.addSubview(img)

      return img
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
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

public extension Array {
    
    /// Element at the given index if it exists.
    ///
    /// - Parameter index: index of element.
    /// - Returns: optional element (if exists).
     func item(at index: Int) -> Element? {
        
        if 0..<self.count ~= index {
            return self[index]
        }
        
        return nil
    }
    
    
    /// Return a random item from array
     func randomItem() -> Element? {
        
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self.item(at: index)
    }
}

