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
    var top = false
    var bottom = false
    
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
        contentView.layer.backgroundColor = UIColor.clear.cgColor
    }
    
    override func layoutSubviews() {
        // Set the width of the cell
        super.layoutSubviews()
          if top {
            container.roundCorners([.topLeft, .topRight], radius: kTableViewCornerRadius)
            container.snp.updateConstraints { make in
                make.top.equalToSuperview().offset(2)
            }
          } else if bottom {
            container.roundCorners([.bottomLeft, .bottomRight], radius: kTableViewCornerRadius)
            container.snp.updateConstraints { make in
                make.bottom.equalToSuperview().offset(-2)
            }
        }
            container.layer.borderColor = UIColor.systemGray4.cgColor
            container.layer.borderWidth = 2
            container.layer.masksToBounds = true

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

    
 
    fileprivate func setupReadMoreLabel() {
        self.readMoreLabel.text = "Read more"
        self.readMoreLabel.textColor = .systemBlue
        self.readMoreLabel.font = UIFont(name: "Futura", size: 12)
        self.readMoreLabel.textAlignment = .center
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
            cell.top = true
        } else if indexPath.row == 3 {
            cell.bottom = true
        } else if indexPath.row == 0 && indexPath.section == 1 {
            cell.top = true
        } else if indexPath.row == 1 && indexPath.section == 1{
            cell.bottom = true
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
        let headerView = view as! UITableViewHeaderFooterView
        headerView.textLabel?.font = UIFont(name: "Futura", size: 11)
        headerView.backgroundView?.backgroundColor = .systemGray5
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
    
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            for index in 0 ..< tableView.visibleCells.count {
                let zPosition = CGFloat(tableView.visibleCells.count - index)
                tableView.visibleCells[index].layer.zPosition = zPosition
            }
        }
    }
}

 extension SettingsProgramTableViewController: UITableViewDelegate { }

fileprivate extension UIView {

    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        self.layer.borderColor = UIColor.systemGray4.cgColor
        self.layer.borderWidth = 2
        self.layer.masksToBounds = true
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
