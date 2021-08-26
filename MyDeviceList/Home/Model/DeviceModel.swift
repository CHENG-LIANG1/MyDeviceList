//
//  DeviceModel.swift
//  MyDeviceList
//
//  Created by 梁程 on 2021/8/24.
//

import UIKit

class Device: NSObject, NSCoding {

    
    var Brand: String?
    var Model: String?
    var Date: String?
    
    init(Brand: String, Model: String, Date: String) {
        self.Brand = Brand
        self.Model = Model
        self.Date = Date
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(Brand, forKey: "Brand")
        coder.encode(Model, forKey: "Model")
        coder.encode(Date, forKey: "Date")
    }
    
    required init?(coder: NSCoder) {
        self.Brand = coder.decodeObject(forKey: "Brand") as? String
        self.Model = coder.decodeObject(forKey: "Model") as? String
        self.Date = coder.decodeObject(forKey: "Date") as? String
    }
    
}
