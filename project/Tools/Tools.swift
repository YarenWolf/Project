//
//  Tools.swift
//  project
//
//  Created by Super on 2017/9/12.
//  Copyright © 2017年 Super. All rights reserved.
//

import UIKit
let bgColor : UIColor =  UIColor(red: 0/255.0, green: 175/255.0, blue: 240/255.0, alpha: 1)
let KEYWINDOW = UIApplication.shared.keyWindow!
let  autoSizeScaleWidth = APPW / 375
let  autoSizeScaleHeight  = APPH / 667
// 设备
let iPhone4S = ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone) && APPH < 568.0)
/**
 swift自定义Log
 - parameter message:    需要打印的内容
 - parameter file:     获取方法调用者所在的文件路径
 - parameter function: 获取方法调用者所在的方法名
 - parameter line:     获取所在的行数
 */
func YYNSLog<T>(_ message: T, fileName: String = #file, methodName: String =  #function, lineNumber: Int = #line){
    #if DEBUG
        let str : String = (fileName as NSString).pathComponents.last!.replacingOccurrences(of: "swift", with: "")
        print("当前类名称：\(str)当前方法名：\(methodName)[当前行数：\(lineNumber)]:打印内容：\(message)")
    #endif
}

/// 定义一个闭包
public typealias ResultClosure = (_ number: String)->()
class Tools: NSObject {
    var bloc:ResultClosure?
    
    
    
    
}
