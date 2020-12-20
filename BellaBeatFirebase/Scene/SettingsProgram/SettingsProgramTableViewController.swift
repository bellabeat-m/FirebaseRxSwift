//
//  SettingsProgramTableViewController.swift
//  BellaBeatFirebase
//
//  Created by Marina Huber on 12/20/20.
//  Copyright © 2020 Marina Huber. All rights reserved.

import UIKit

class ProgramCell: UITableViewCell {
    
    static let identifier = "Cell"
    private var images: [String] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    lazy var titleLabel: UILabel = {
        let title = UILabel(frame: .zero)
        title.textAlignment = .right
        title.numberOfLines = 0
        title.lineBreakMode = .byWordWrapping
        title.font = UIFont.systemFont(ofSize: 19, weight: .light)
        title.textColor = .black
        
        return title
    }()
    
    
    lazy var iconImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "\(images)"))
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
        img.contentMode = .scaleAspectFit
        
        return img
    }()
    
    lazy var viewCell: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .white
        
        return view
    }()
    
    
    func setupConstraints() {
        contentView.addSubview(viewCell)
        contentView.addSubview(titleLabel)
        contentView.addSubview(iconImage)
        contentView.layer.backgroundColor = UIColor.systemGray6.cgColor
        
        viewCell.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
        }
        
        iconImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(7)
            make.leading.equalTo(viewCell.safeAreaLayoutGuide).offset(10)
            make.width.equalTo(25)
            make.height.equalTo(25)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImage.snp.leading).offset(35)
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(10)
        }
    }
    
}


class SettingsProgramTableViewController: UIViewController {

    fileprivate var tableView = UITableView()
    fileprivate var restartProgramInfoLabel = UILabel()
    fileprivate var readMoreLabel = UILabel()

    
    deinit {
       // Debug.log("SettingsChooseProgramsViewController deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setupTableView()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.default
    }
    
    //  MARK: - setup methods
    private func setupNavigationBar() {
        self.title = "Your personilized program"
    }
    
    private func setupDataV0() {
        //set up observables
    }
    
    private func setupDataV1() {
        //set up observables
    }


    private func setupTableView() {
        self.view.addSubview(self.tableView)
        tableView.rowHeight = 100
        tableView = UITableView(frame: .zero)
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        tableView.backgroundColor = .systemGray6
        tableView.register(ProgramCell.self, forCellReuseIdentifier: ProgramCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
    private func addPrograms() {

    }
    
    private func updateReadMoreLabelConstraints() {
        self.readMoreLabel.snp.remakeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.restartProgramInfoLabel.snp.bottom).offset(15)
            make.bottom.equalTo(0).offset(-Constants.edgeOffset)
        }
    }
    
 
    fileprivate func setupReadMoreLabel() {
        self.readMoreLabel.text = "general_read_more"
        self.readMoreLabel.textColor = .systemBlue
        self.readMoreLabel.font = UIFont(name: "", size: 12)
        self.readMoreLabel.textAlignment = .center
    }
}

extension SettingsProgramTableViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProgramCell.identifier, for: indexPath) as! ProgramCell
        cell.titleLabel.text = "data missing"
        cell.iconImage.image = UIImage(named: "IMG_0")
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection
                                section: Int) -> String? {
       return "Main"
    }

   func tableView(_ tableView: UITableView, titleForFooterInSection
                                section: Int) -> String? {
       return "Supportive"
    }
}

 extension SettingsProgramTableViewController: UITableViewDelegate {
    
    
}

fileprivate struct Constants {
    static let componentDistance = 15.0
    static let edgeOffset: CGFloat = 15.0
    static let borderWidth = 1
    static let borderColor = UIColor.systemGray6
}

fileprivate extension UIView {
    func setBorders() {
        self.layer.borderColor = Constants.borderColor.cgColor
        self.layer.borderWidth = CGFloat(Constants.borderWidth)
    }
}

