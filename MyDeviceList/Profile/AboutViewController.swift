//
//  ProfileViewController.swift
//  MyDeviceList
//
//  Created by 梁程 on 2021/8/23.
//

import UIKit

class AboutViewController: UIViewController {
    let iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "logo")
        Tools.setWidth(iv, 250)
        Tools.setHeight(iv, 250)
        iv.layer.borderWidth = 10
        iv.layer.cornerRadius = 20
        iv.layer.borderColor = K.darkPink.cgColor
        iv.clipsToBounds = true
        return iv
    }()
    
    let versionLabel = Tools.setUpLabel("Version: \(K.versionId)", K.darkPink, 15, .semibold)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "About"
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
        view.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make  in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view).offset(-160)
        }
        view.addSubview(versionLabel)
        versionLabel.snp.makeConstraints { make  in
            make.bottom.equalTo(view).offset(-15)
            make.centerX.equalTo(view)
        }
        
   
    }
    
}
