//
//  ASPlusController.swift
//  BaiSiApp
//
//  Created by ashen on 16/3/29.
//  Copyright © 2016年 Ashen<http://www.devashen.com>. All rights reserved.
import UIKit
class ASPlusController: UIViewController {
    var titleIMgv: UIImageView!
    var cancel: UIButton!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        for view in self.view.subviews {
            view.transform = CGAffineTransform(translationX: 0, y: -600)
        }
        cancel.transform = CGAffineTransform(translationX: 0, y: 0)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        for view in self.view.subviews {
            var delay:Double = 0.0
            switch view.tag {
            case 1001:delay = 0.25
            case 1002:delay = 0.15
            case 1003:delay = 0.2
            case 1004:delay = 0.1
            case 1005:delay = 0.0
            case 1006:delay = 0.05
            case 1007:delay = 0.0
            default:delay = 0.3
            }
            UIView.animate(withDuration: 0.6,delay: delay,usingSpringWithDamping: 0.82,initialSpringVelocity: 0,options: .curveEaseOut,animations: { () -> Void in
                view.transform = CGAffineTransform.identity
            }) { (bool:Bool) -> Void in
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        cancel.layer.borderColor = UIColor.lightGray.cgColor
        cancel.layer.borderWidth = 0.6
        cancel.layer.cornerRadius = 2
        cancel.layer.masksToBounds = true
    }
    //MARK: -Actions
    func publishActions(_ sender: UIButton) {
        switch sender.tag {
        case 1001:print("发视频")
        case 1002:print("发图片")
        case 1003:print("发段子")
        case 1004:print("发声音")
        case 1005:print("审核")
        case 1006:print("发连接")
        default:break
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double((Int64)(0.5 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) {
            
        }
    }
    func cancel(_ sender: AnyObject) {
        for view in self.view.subviews {
            var delay:Double = 0.0
            switch view.tag {
            case 1001:delay = 0.25
            case 1002:delay = 0.15
            case 1003:delay = 0.2
            case 1004:delay = 0.1
            case 1005:delay = 0.02
            case 1006:delay = 0.05
            case 1007:delay = 0.0
            default:delay = 0.3
            }
            UIView.animate(withDuration: 0.5,delay: delay,usingSpringWithDamping: 1,initialSpringVelocity: 0,options: .curveEaseOut,animations: { () -> Void in
                view.transform = CGAffineTransform(translationX: 0, y: 500)
                                        
            }) { (bool:Bool) in
                self.dismiss(animated: false, completion: nil)
            }
        }
    }
}
