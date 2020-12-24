//
//  SettingsProgramTableViewController.swift
//  BellaBeatFirebase
//
//  Created by Marina Huber on 12/20/20.
//  Copyright © 2020 Marina Huber. All rights reserved.

import UIKit

class ProgramCell: UITableViewCell {
    
    static let identifier = "ProgramSettingsCell"
    var image1: String?
    var kTableViewCornerRadius: CGFloat = 13.0
    var topCorners = false
    var bottomCorners = false
    
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
        let img = UIImageView(image: UIImage(named: "\(image1)"))
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
        img.contentMode = .scaleAspectFit
        
        return img
    }()
    
    lazy var container: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = false
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .white
        
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupViews() {
        contentView.addSubview(container)
        contentView.addSubview(titleLabel)
        contentView.addSubview(iconImage)
        if topCorners {
            container.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(1)
            }
        } else if bottomCorners {
            container.snp.makeConstraints { make in
                make.bottom.equalToSuperview().offset(1)
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        container.layer.borderColor = UIColor.systemGray4.cgColor
        container.layer.borderWidth = 2
        DispatchQueue.main.async {
            if self.topCorners {
                self.container.roundBorderCorners([.topLeft, .topRight], radius: self.kTableViewCornerRadius)
                
            } else if self.bottomCorners {
                self.container.roundBorderCorners([.bottomLeft, .bottomRight], radius: self.kTableViewCornerRadius)
            }
        }
        self.layoutIfNeeded()
    }
    
    //    func setupCell(data: ProgramContent) {
    //        self.titleLabel.text = data.name
    //    }
    
    func setupConstraints() {
        container.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(-1)
            make.bottom.equalToSuperview().offset(1)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
        }
        
        iconImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(7)
            make.leading.equalTo(container.safeAreaLayoutGuide).offset(10)
            make.width.equalTo(25)
            make.height.equalTo(25)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImage.snp.leading).offset(35)
            make.top.equalTo(container.safeAreaLayoutGuide).offset(10)
        }
    }
    
}





class SettingsProgramTableViewController: UIViewController {

    fileprivate var tableView = UITableView()
    fileprivate var readMoreLabel = UILabel()
    fileprivate var isFirstSection = false
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        self.title = "settings"
        self.view.backgroundColor = .systemGray5

    }

    private func setupDataV0() {
        //set up observables
    }
    
    private func setupDataV1() {
        //set up observables
    }

    private func setupTableView() {
        self.tableView = UITableView(frame: .zero)
        self.view.addSubview(self.tableView)
        tableView.rowHeight = 100
        tableView = UITableView(frame: .zero)
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
           // make.height.equalTo(50).constraint
            make.edges.equalToSuperview()
//             make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
//             make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
//             make.height.equalTo(view.frame.height)
            // make.width.equalTo(view.safeAreaLayoutGuide.snp.width)
             
           // make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
//          let footerView: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width:320 , height: 500))
//          footerView.text = "add description ro Timevc in order user will see the result of lesson time"
//          footerView.numberOfLines = 0
//          footerView.font = UIFont(name: "Futura", size: 11)
//          footerView.sizeToFit()
//        tableView.tableFooterView = footerView
//        let headerView: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width:320 , height: 500))
//        headerView.text = "test test add description ro Timevc in order user will see the result of lesson time"
//        headerView.numberOfLines = 0
//        headerView.font = UIFont(name: "Futura", size: 11)
//        headerView.sizeToFit()
        tableView.backgroundColor = .systemGray5
        tableView.register(ProgramCell.self, forCellReuseIdentifier: ProgramCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorColor = .clear
        tableView.isScrollEnabled = false

    }
    
    private func addPrograms() {

    }
}

extension SettingsProgramTableViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 4
        } else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProgramCell.identifier, for: indexPath) as! ProgramCell
        
        if indexPath.row == 0 && indexPath.section == 0 {
            cell.topCorners = true
        }
         if indexPath.row == 3 {
            cell.bottomCorners = true
        } else if indexPath.row == 0 && indexPath.section == 1 {
            cell.topCorners = true
        } else if indexPath.row == 1 && indexPath.section == 1{
            cell.bottomCorners = true
        }
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.titleLabel.text = "data here to ..."
        cell.iconImage.image = UIImage(named: "IMG_8")
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection
            section: Int) -> String? {
            isFirstSection = section == 0
            let headerTitle = isFirstSection ? "Main" : "Supportive"
            return headerTitle
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let headerView = view as! UITableViewHeaderFooterView
        headerView.textLabel?.font = UIFont(name: "Futura", size: 16)
        headerView.backgroundView?.backgroundColor = .systemGray5
    }
    //TODO: Resizable footer view
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        if let footerView = view as? UITableViewHeaderFooterView {
            footerView.textLabel?.font = UIFont(name: "Futura", size: 11)
            footerView.textLabel?.lineBreakMode = .byWordWrapping
            footerView.textLabel?.numberOfLines = 0
            footerView.sizeToFit()
            footerView.backgroundView?.backgroundColor = .systemGray5
        }
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView {
        let label = UILabel(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.size.width, height: 60))
        label.font = UIFont(name: "Futura", size: 11)
        isFirstSection = section == 0
        label.text = isFirstSection ? "If you want to restart your program, deselect and than reselect all settings" : "Based on your personal want to restart your program, deselect and than reselect the want to deselect and than reselect the program, deselect and than reselect thprogram, deselect and than reselect program, deselect and restart.."
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
//    func tableView(_ tableView: UITableView, titleForFooterInSection
//        section: Int) -> String? {
//        isFirstSection = section == 0
//        let footerTitle = isFirstSection ? "If you want to restart your program, deselect and than reselect all settings" : "Based on your personal want to restart your program, deselect and than reselect the want to deselect and than reselect the program, deselect and than reselect thprogram, deselect and than reselect program, deselect and restart.."
//        return footerTitle
//    }

}

 extension SettingsProgramTableViewController: UITableViewDelegate { }

fileprivate extension UIView {
    
    func roundBorderCorners(_ corners: UIRectCorner, radius: CGFloat) {
           let path = UIBezierPath(roundedRect: self.bounds,
                                   byRoundingCorners: corners,
                                   cornerRadii: CGSize(width: radius, height: radius))
           let mask = CAShapeLayer()
           mask.path = path.cgPath
           self.layer.mask = mask
           let borderLayer = CAShapeLayer()
           borderLayer.path = mask.path
           borderLayer.fillColor = UIColor.clear.cgColor
           borderLayer.strokeColor = UIColor.systemGray4.cgColor
           borderLayer.lineWidth = 2
           borderLayer.frame = self.bounds
           self.layer.addSublayer(borderLayer)
       }
}
