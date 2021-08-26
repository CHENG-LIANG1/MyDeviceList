//
//  DeviceTableViewCell.swift
//  MyDeviceList
//
//  Created by 梁程 on 2021/8/23.
//

import UIKit

class DeviceTableViewCell: UITableViewCell {
    let containerView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 0.15
        view.layer.cornerRadius = 12
        return view
    }()
    
    let brandLabel = Tools.setUpLabel("brand", .black, 25, .semibold)
    let modelLabel = Tools.setUpLabel("model", .darkGray, 18, .semibold)
    let yearLabel = Tools.setUpLabel("year", K.darkBlue, 20, .semibold)
    
    let offset = 10

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(containerView)
        contentView.backgroundColor = .white
        containerView.snp.makeConstraints { make  in
            make.top.equalTo(contentView).offset(offset)
            make.right.equalTo(contentView).offset(-offset * 2)
            make.bottom.equalTo(contentView).offset(-offset)
            make.left.equalTo(contentView).offset(offset * 2)
        }
        
        containerView.addSubview(brandLabel)
        containerView.addSubview(modelLabel)
        containerView.addSubview(yearLabel)
        
        brandLabel.snp.makeConstraints { make  in
            make.top.equalTo(containerView).offset(8)
            make.left.equalTo(containerView).offset(10)
        }
        
        modelLabel.snp.makeConstraints { make  in
            make.top.equalTo(brandLabel.snp_bottomMargin).offset(15)
            make.left.equalTo(containerView).offset(10)
        }
        
        yearLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        yearLabel.snp.makeConstraints {  make  in
            make.right.equalTo(containerView).offset(-15)
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

