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
    
    let container: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
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
        //contentView.layer.backgroundColor = UIColor.clear.cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        container.clipsToBounds = true
        container.layer.borderColor = UIColor.systemGray4.cgColor
        container.layer.borderWidth = 2
        if topCorners {
            container.roundBorderCorners([.topLeft, .topRight], radius: kTableViewCornerRadius)
            container.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(2)
            }
        } else if bottomCorners {
            container.roundBorderCorners([.bottomLeft, .bottomRight], radius: kTableViewCornerRadius)
            container.snp.makeConstraints { make in
                make.bottom.equalToSuperview().offset(-2)
            }
        }
    }
    
    func setupConstraints() {
        container.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(-2)
            make.bottom.equalToSuperview().offset(2)
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
    
    //    func setupCell(data: ProgramContent) {
    //        self.titleLabel.text = data.name
    //    }
        


    
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
        self.tableView = UITableView(frame: .zero)
        self.view.addSubview(self.tableView)
        self.setupTableView(view: tableView)
        tableView.register(ProgramCell.self, forCellReuseIdentifier: ProgramCell.identifier)

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


    private func setupTableView(view: UITableView) {
        tableView.rowHeight = 100
        tableView = UITableView(frame: .zero)
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        tableView.backgroundColor = .systemGray5
        tableView.register(ProgramCell.self, forCellReuseIdentifier: ProgramCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorColor = .clear

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
            cell.container.roundBorderCorners([.topLeft, .topRight], radius: 13)
            cell.container.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(2)
            }
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
        cell.titleLabel.text = "data here to ..."
        cell.iconImage.image = UIImage(named: "IMG_8")
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let headerView = view as! UITableViewHeaderFooterView
        headerView.textLabel?.font = UIFont(name: "Futura", size: 16)
        headerView.backgroundView?.backgroundColor = .systemGray5
    }
    //TODO: Resizable footer view
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        let footerView = view as! UITableViewHeaderFooterView
        footerView.textLabel?.font = UIFont(name: "Futura", size: 11)
        footerView.textLabel?.numberOfLines = 0
        footerView.backgroundView?.backgroundColor = .systemGray5
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection
        section: Int) -> String? {
        isFirstSection = section == 0
        let headerTitle = isFirstSection ? "Main" : "Supportive"
        return headerTitle
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection
        section: Int) -> String? {
        isFirstSection = section == 0
        let footerTitle = isFirstSection ? "If you want to restart your program, deselect and than reselect the..." : "Based on your personal want to restart your program, deselect and than reselect the want to deselect and than reselect the.."
        return footerTitle
    }

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
           borderLayer.path = mask.path // Reuse the Bezier path
           borderLayer.fillColor = UIColor.clear.cgColor
           borderLayer.strokeColor = UIColor.systemGray4.cgColor
           borderLayer.lineWidth = 2
           borderLayer.frame = self.bounds
           self.layer.addSublayer(borderLayer)
       }

}
