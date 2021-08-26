//
//  GameTools.swift
//  BladeCloudGame
//
//  Created by 梁程 on 2021/6/30.
//

import UIKit

struct Tools {

    public static func setUpTableView(borderWidth: Float, rowHeight:Int, enableScroll: Bool) -> UITableView {
        let tableView: UITableView = {
            let tv = UITableView()
            tv.translatesAutoresizingMaskIntoConstraints = false
            tv.layer.cornerRadius = 12
            tv.separatorStyle = .none
            tv.layer.borderWidth = CGFloat(borderWidth)
            tv.rowHeight = CGFloat(rowHeight)
            tv.isScrollEnabled = enableScroll
            return tv
        }()
        return tableView
    }

    public static func setUpButton(_ btnTitle: String, _ color: UIColor, _ fontSize: Int, _ width: Int, _ height: Float, _ fontWeight: UIFont.Weight) -> UIButton {
        let btn = UIButton()
        btn.layer.cornerRadius = 10
        btn.backgroundColor = color
        btn.setTitle(btnTitle, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: CGFloat(fontSize), weight: fontWeight)
        setHeight(btn, height)
        setWidth(btn, width)
        return btn
    }
    
    
    public static func setUpLabel(_ text: String, _ color: UIColor, _ fontSize: Int, _ fontWeight: UIFont.Weight) -> UILabel {
        let lbl = UILabel()
        lbl.text = text
        lbl.textColor = color
        lbl.font = .systemFont(ofSize: CGFloat(fontSize), weight: fontWeight)
        return lbl
    }

    public static func setUpTextField(_ height: Float, _ placeHolder: String, _ borderWidth: Float, _ borderColor: UIColor) -> UITextField{
        let tf = UITextField()
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont(name: "Arial", size: 15)]
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.font = .systemFont(ofSize: 20, weight: .semibold)
        tf.borderStyle = .none
        tf.placeholder = placeHolder
        tf.layer.borderWidth = CGFloat(borderWidth)
        tf.layer.borderColor = borderColor.cgColor
        tf.layer.cornerRadius = 12
        tf.attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: attributes as [NSAttributedString.Key : Any])
        setHeight(tf, height)
        return tf
    }
    
    public static func setHeight( _ sender: UIView, _ height: Float){
        sender.heightAnchor.constraint(equalToConstant: CGFloat(height)).isActive = true
    }
    public static func setWidth(_ sender: UIView, _ width: Int){
        sender.widthAnchor.constraint(equalToConstant: CGFloat(width)).isActive = true
    }
}

public extension UIView {
    func showAnimation(_ completionBlock: @escaping () -> Void) {
      isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.1,
                       delay: 0,
                       options: .curveLinear,
                       animations: { [weak self] in
                            self?.transform = CGAffineTransform.init(scaleX: 0.95, y: 0.95)
        }) {  (done) in
            UIView.animate(withDuration: 0.1,
                           delay: 0,
                           options: .curveLinear,
                           animations: { [weak self] in
                                self?.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            }) { [weak self] (_) in
                self?.isUserInteractionEnabled = true
                completionBlock()
            }
        }
    }
    
    func addShadow() {
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        self.layer.shadowOffset = CGSize(width: 2.0, height: 0.5)
        self.layer.shadowOpacity = 0.9
        self.layer.shadowRadius = 1.0
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    

}

enum LinePosition {
    case top
    case bottom
}

extension UIView {
    func addLine(position: LinePosition, color: UIColor, width: Double) {
        let lineView = UIView()
        lineView.backgroundColor = color
        lineView.translatesAutoresizingMaskIntoConstraints = false // This is important!
        self.addSubview(lineView)

        let metrics = ["width" : NSNumber(value: width)]
        let views = ["lineView" : lineView]
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[lineView]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))

        switch position {
        case .top:
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[lineView(width)]", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
            break
        case .bottom:
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[lineView(width)]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
            break
        }
    }
}

extension UserDefaults {
    func imageArray(forKey key: String) -> [UIImage]? {
        guard let array = self.array(forKey: key) as? [Data] else {
            return nil
        }
        return array.compactMap() { UIImage(data: $0) }
    }

    func set(_ imageArray: [UIImage], forKey key: String) {
        self.set(imageArray.compactMap({ $0.pngData() }), forKey: key)
    }
}

extension UIButton {
    func setBackgroundColor(color: UIColor, forState: UIControl.State) {
        self.clipsToBounds = true  // add this to maintain corner radius
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
            let colorImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.setBackgroundImage(colorImage, for: forState)
        }
    }
}
