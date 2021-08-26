//
//  AddDeviceViewController.swift
//  MyDeviceList
//
//  Created by 梁程 on 2021/8/24.
//

import UIKit
import SCLAlertView

class AddDeviceViewController: UIViewController {
    let offset = 20
    let brandTextField = Tools.setUpTextField(45, "Select a brand", 1.8, K.darkBlue)
    let modelTextField = Tools.setUpTextField(45, "Enter a model", 1.8, K.darkBlue)
    let yearTextField = Tools.setUpTextField(45, "When did you buy it?", 1.8, K.darkBlue)
    let addButton = Tools.setUpButton("Add device", K.darkBlue, 25, Int(K.screenWidth) - 20 * 2, 50, .semibold)
    var deviceArray: [Device] = []
    let deviceImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 15
        iv.image = UIImage(named: "devices")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        Tools.setHeight(iv, Float(K.screenHeight) / 4)
        return iv
    }()
    let brandPicker = UIPickerView()
    let yearPicker = UIPickerView()

    var selectedBrand: String?
    var selectedYear: String?
    var brandList = ["Apple", "Samsung", "Sony", "Google", "LG", "Xiaomi", "OnePlus", "Essential", "Vivo", "OPPO", "Huawei", "ZTE", "Meizu", "Smartisan", "Redmi", "Realme", "Honor", "BlackShark", "nubia", "Hisense", "HXM",  "ASUS", "Dell", "Alienware", "Lenovo", "HTC", "Acer", "iQOO", "Goinee","Coolpad","Nokia", "Motorola", "ROG"]
    var yearList = [Int]()

    func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "OK", style: .plain, target: self, action: #selector(self.dismissKeyboard))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        brandTextField.inputAccessoryView = toolBar
        yearTextField.inputAccessoryView = toolBar
    }
    @objc func dismissKeyboard() {
          view.endEditing(true)
    }
    @objc func addAction(sender: UIButton){
        sender.showAnimation { [self] in
            if brandTextField.text == "" || modelTextField.text == "" || yearTextField.text == "" {
                SCLAlertView().showTitle("Missing fields!", subTitle: "Please fill in all the text fields.", style:.error, colorStyle: 0xFF4848)
            }else{

                let newDevice = Device(Brand: selectedBrand!, Model: modelTextField.text!, Date: selectedYear!)
                if let devices = UserDefaults.standard.object(forKey: "Devices") as? NSData {
                deviceArray = NSKeyedUnarchiver.unarchiveObject(with: devices as Data) as! [Device]
                        }
                deviceArray.append(newDevice)
                let devicesToStore = NSKeyedArchiver.archivedData(withRootObject: deviceArray)
                UserDefaults.standard.setValue(devicesToStore, forKey: "Devices")

                
                self.navigationController?.popViewController(animated: true)
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "Add a device"
        brandPicker.delegate = self
        yearPicker.delegate = self
        brandTextField.inputView = brandPicker
        yearTextField.inputView = yearPicker
        dismissPickerView()
        
        brandTextField.delegate = self
        modelTextField.delegate = self
        yearTextField.delegate = self
        brandTextField.setLeftPaddingPoints(10)
        modelTextField.setLeftPaddingPoints(10)
        yearTextField.setLeftPaddingPoints(10)

        
        addButton.addTarget(self, action: #selector(addAction(sender:)), for: .touchUpInside)
        addButton.setBackgroundColor(color: K.darkPink, forState: .highlighted)
        
        brandList.sort()
        
        let year = Calendar.current.component(.year, from: Date())
        for i in 1980...year{
            self.yearList.append(i)
        }
        

        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
                tap.cancelsTouchesInView = false
                view.addGestureRecognizer(tap)
        
        view.addSubview(deviceImageView)
        deviceImageView.snp.makeConstraints { make  in
            make.top.equalTo(view).offset(150)
            make.left.equalTo(view).offset(offset)
            make.right.equalTo(view).offset(-offset)
        }
        
        view.addSubview(brandTextField)
        brandTextField.snp.makeConstraints { make  in
            make.top.equalTo(deviceImageView.snp_bottomMargin).offset(30)
            make.left.equalTo(view).offset(offset)
            make.right.equalTo(view).offset(-offset)
        }
        
        view.addSubview(modelTextField)
        modelTextField.snp.makeConstraints { make  in
            make.top.equalTo(brandTextField.snp_bottomMargin).offset(30)
            make.left.equalTo(view).offset(offset)
            make.right.equalTo(view).offset(-offset)
        }
        
        view.addSubview(yearTextField)
        yearTextField.snp.makeConstraints { make  in
            make.top.equalTo(modelTextField.snp_bottomMargin).offset(30)
            make.left.equalTo(view).offset(offset)
            make.right.equalTo(view).offset(-offset)
        }
        
        view.addSubview(addButton)
        addButton.snp.makeConstraints { make  in
            make.top.equalTo(yearTextField.snp_bottomMargin).offset(30)
            make.left.equalTo(view).offset(offset)
            make.right.equalTo(view).offset(-offset)
        }
    }
}

extension AddDeviceViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == brandPicker {
            return brandList.count
        }else{
            return yearList.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == brandPicker {
            return brandList[row]
        }else{
            return "\(yearList[row])"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == brandPicker {
            selectedBrand = brandList[row]
            brandTextField.textColor = .black
            brandTextField.text = selectedBrand
        }else{
            selectedYear = "\(yearList[row])"

            yearTextField.textColor = .black
            yearTextField.text = selectedYear
        }
    }
}


extension AddDeviceViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = K.darkPink.cgColor
        textField.layer.borderWidth = 3.0
        textField.textColor = .black
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = K.darkBlue.cgColor
        textField.layer.borderWidth = 1.8
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        
        return true
    }
}
