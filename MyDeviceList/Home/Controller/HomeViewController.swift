//
//  HomeViewController.swift
//  MyDeviceList
//
//  Created by 梁程 on 2021/8/23.
//

import UIKit
import SnapKit
import SCLAlertView

class HomeViewController: UIViewController {
    let addButton = UIButton(type: .custom)
    var addImage: UIImage?
    var deviceArray: [Device] = []
    
    @objc func addButtonPressed(sender: UIButton){
        sender.showAnimation {
            let vc = AddDeviceViewController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    let devicesTableView = Tools.setUpTableView(borderWidth: 0, rowHeight: 100, enableScroll: true)
    let infoLabel = Tools.setUpLabel("Nothing here.\nClick ➕ to add📱.", K.darkPink, 20, .semibold)
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        view.backgroundColor = .white
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = .white
//        self.navigationController?.navigationBar.prefersLargeTitles = true
//        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]

        self.title = "My Devices"
        

//        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        devicesTableView.backgroundColor = .white
        addImage = UIImage(named: "plus")
        
        devicesTableView.delegate = self
        devicesTableView.dataSource = self
        
        if let devices = UserDefaults.standard.object(forKey: "Devices") as? NSData {
        deviceArray = NSKeyedUnarchiver.unarchiveObject(with: devices as Data) as! [Device]
            devicesTableView.reloadData()
        }
        
        addButton.setImage(addImage, for: .normal)
        addButton.addTarget(self, action: #selector(addButtonPressed(sender:)), for: .touchUpInside)
        addButton.contentVerticalAlignment = .fill
        addButton.contentHorizontalAlignment = .fill
        Tools.setHeight(addButton, 50)
        Tools.setWidth(addButton, 50)
        
        devicesTableView.register(DeviceTableViewCell.self, forCellReuseIdentifier: "DeviceCell")
        
        view.addSubview(addButton)
        view.addSubview(devicesTableView)
        view.addSubview(infoLabel)
        addButton.superview?.bringSubviewToFront(addButton)
        addButton.snp.makeConstraints { make  in
            make.bottom.equalTo(view).offset(-40)
            make.right.equalTo(view).offset(-30)
        }
        
        devicesTableView.snp.makeConstraints { make  in
            make.top.equalTo(view)
            make.bottom.equalTo(view)
            make.left.equalTo(view)
            make.right.equalTo(view)
        }
        
        infoLabel.textAlignment = .center
        infoLabel.numberOfLines = 2
        infoLabel.font = UIFont(name: "Menlo", size: 20)
        infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        infoLabel.snp.makeConstraints { make  in
            make.centerY.equalTo(view)
        }
        devicesTableView.superview?.bringSubviewToFront(devicesTableView)
        addButton.superview?.bringSubviewToFront(addButton)
        if deviceArray.count == 0 {
            devicesTableView.isHidden = true
        }else{
            devicesTableView.isHidden = false
        }
        
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deviceArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DeviceCell", for: indexPath) as! DeviceTableViewCell
        cell.selectionStyle = .none
        cell.brandLabel.text = deviceArray[indexPath.row].Brand
        cell.modelLabel.text = deviceArray[indexPath.row].Model
        cell.yearLabel.text = deviceArray[indexPath.row].Date
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { [self] action, indexPath in
                deviceArray.remove(at: indexPath.row)
                let devicesToStore = NSKeyedArchiver.archivedData(withRootObject: deviceArray)
                UserDefaults.standard.setValue(devicesToStore, forKey: "Devices")
                tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            
            if deviceArray.count == 0 {
                devicesTableView.isHidden = true
            }else{
                devicesTableView.isHidden = false
            }
        }
        
        
        return [delete]
    }
    
}
