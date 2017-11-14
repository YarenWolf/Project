////
////  AVCaptureSessionManager.swift
////  ZZYQRCodeSwift
////
////  Created by 张泽宇 on 2017/5/23.
////  Copyright © 2017年 zzy. All rights reserved.
////
//
//import UIKit
//import AVFoundation
//import Photos
//
//import Foundation
//typealias SuccessBlock = (String?) -> Void
//typealias GrantBlock = () -> ()
//typealias DeniedBlock = () -> ()
//
//import CoreImage
//
//class CreateViewController: UIViewController {
//    var QRImage: UIImageView!
//    var QRImageBg: UIImageView!
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        QRImage = UIImageView(frame: CGRect(x: 10, y: 100, width: 200, height: 200))
//        QRImageBg = UIImageView(frame: CGRect(x: 10, y: 350, width: 200, height: 200))
//        view.addSubview(QRImageBg)
//        view.addSubview(QRImageBg)
//        let image = UIImage(named: "bigMax")
//        QRImage.image = UIImage.createCustomizeQRCode(size: 200,dataStr: "hello",imageType: .CircularImage,iconImage: image!,iconImageSize: 40)
//        let temp = UIImage.createCustomizeQRCode(size: 150,dataStr: "hello",imageType: .SquareImage,iconImage: image!,iconImageSize: 40);
//        let bgImage = UIImage(named: "flower")
//        QRImageBg.image = UIImage.addQRCodeBg(bgImage: bgImage!, bgImageSize: 200, QRImage: temp!)
//    }
//    
//}
//class ScanViewController: UIViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate{
//    var sessionManager:AVCaptureSessionManager?
//    var link: CADisplayLink?
//    var torchState = false
//    
//    
//    var QRImage: UIImageView!
//    var QRImageBg: UIImageView!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        let light = UIButton(frame: CGRect(x: 10, y: 100, width: 100, height: 20))
//        light.setTitle("开启闪光灯", for: .normal)
//        light.backgroundColor = .red
//        light.addTarget(self, action: #selector(self.changeState(_:)), for: .touchUpInside)
//        view.addSubview(light)
//        QRImageBg = UIImageView(frame: CGRect(x: 10, y: 350, width: 200, height: 200))
//        QRImage = UIImageView(frame: CGRect(x: 10, y: 150, width: 200, height: 200))
//        QRImage.image = UIImage(named: "qrcode_scanline_qrcode")
//        QRImageBg.image = UIImage(named: "qrcode_border")
//        view.addSubview(QRImageBg)
//        view.addSubview(QRImage)
//        link = CADisplayLink(target: self, selector: #selector(scan))
//        
//        sessionManager = AVCaptureSessionManager(captureType: .AVCaptureTypeBoth, scanRect: CGRect.null, success: { (result) in
//            if let r = result {
//                self .showResult(result: r)
//            }
//        })
//        sessionManager?.showPreViewLayerIn(view: view)
//        sessionManager?.isPlaySound = true
//        
//        let item = UIBarButtonItem(title: "相册", style: .plain, target: self, action: #selector(openPhotoLib))
//        navigationItem.rightBarButtonItem = item
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        link?.add(to: RunLoop.main, forMode: RunLoopMode.commonModes)
//        sessionManager?.start()
//    }
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        link?.remove(from: RunLoop.main, forMode: RunLoopMode.commonModes)
//        sessionManager?.stop()
//    }
//    
//    func scan() {
//        
//        QRImage.frame.origin.y+=1;
//        
//        if (QRImage.frame.origin.y >= 350) {
//            QRImage.frame.origin.y = 150;
//        }
//    }
//    
//    func changeState(_ sender: UIButton) {
//        torchState = !torchState
//        let str = torchState ? "关闭闪光灯" : "开启闪光灯"
//        sessionManager?.turnTorch(state: torchState)
//        sender.setTitle(str, for: .normal)
//    }
//    
//    
//    func showResult(result: String) {
//        let alert = UIAlertView(title: "扫描结果", message: result, delegate: nil, cancelButtonTitle: "确定")
//        alert .show()
//    }
//    
//    func openPhotoLib() {
//        AVCaptureSessionManager.checkAuthorizationStatusForPhotoLibrary(grant: {
//            let imagePicker = UIImagePickerController()
//            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
//            imagePicker.delegate = self
//            self.present(imagePicker, animated: true, completion: nil)
//        }) {
//            let action = UIAlertAction(title: "确定", style: UIAlertActionStyle.default, handler: { (action) in
//                let url = URL(string: UIApplicationOpenSettingsURLString)
//                UIApplication.shared.openURL(url!)
//            })
//            let con = UIAlertController(title: "权限未开启",
//                                        message: "您未开启相册权限，点击确定跳转至系统设置开启",
//                                        preferredStyle: UIAlertControllerStyle.alert)
//            con.addAction(action)
//            self.present(con, animated: true, completion: nil)
//        }
//    }
//    
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        sessionManager?.start()
//        dismiss(animated: true, completion: nil)
//    }
//    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        dismiss(animated: true) {
//            self.sessionManager?.start()
//            self.sessionManager?.scanPhoto(image: info["UIImagePickerControllerOriginalImage"] as! UIImage, success: { (str) in
//                if let result = str {
//                    self.showResult(result: result)
//                }else {
//                    self.showResult(result: "未识别到二维码")
//                }
//            })
//            
//        }
//    }
//    
//    
//}
//extension UIImage {
//    
//    enum QRCodeImageType {
//        case CircularImage
//        case SquareImage
//    }
//    
//    /// 创建普通二维码
//    ///
//    /// - Parameters:
//    ///   - size: 二维码大小
//    ///   - dataStr: 二维码包含字符
//    /// - Returns: 二维码图片
//    class func createQRCode(size: CGFloat, dataStr: String) -> UIImage? {
//        
//        let filter = CIFilter(name: "CIQRCodeGenerator")
//        filter?.setDefaults()
//        
//        let data = dataStr.data(using: .utf8)
//        filter?.setValue(data, forKey: "inputMessage")
//        guard let cIImage = filter?.outputImage else {
//            return nil
//        }
//        return self .createNonInterpolatedUIImage(image: cIImage, size: size)
//    }
//    
//    
//    
//    /// 生成自定义二维码
//    ///
//    /// - Parameters:
//    ///   - size: 二维码大小
//    ///   - dataStr: 二维码包含字符
//    ///   - imageType: 二维码中自定义图片类型
//    ///   - iconImage: 二维码中包含的小图片
//    ///   - iconImageSize: 小图片的大小
//    /// - Returns: 自定义二维码
//    class func createCustomizeQRCode(size: CGFloat,
//                                     dataStr: String,
//                                     imageType: QRCodeImageType,
//                                     iconImage: UIImage,
//                                     iconImageSize: CGFloat) -> UIImage? {
//        guard let bgImage = UIImage.createQRCode(size: size, dataStr: dataStr) else {
//            return nil
//        }
//        var tempImage: UIImage? = iconImage
//        if imageType == .CircularImage {
//            tempImage = UIImage.createCircularImage(image: iconImage)
//        }
//        var result :UIImage?
//        if let t = tempImage {
//            result = UIImage.createNewImage(bgImage: bgImage, iconImage: t, iconSize: iconImageSize)
//        }
//        return result
//    }
//    
//    
//    
//    /// 为二维码添加背景
//    ///
//    /// - Parameters:
//    ///   - bgImage: 背景图片
//    ///   - bgImageSize: 背景图片大小
//    ///   - QRImage: 二维码图片
//    /// - Returns: 添加过背景的二维码
//    class func addQRCodeBg(bgImage: UIImage, bgImageSize:CGFloat, QRImage: UIImage) -> UIImage? {
//        let tempImage = UIImage.imageCompress(sourceImage: bgImage, size: CGSize(width: bgImageSize, height: bgImageSize))
//        return  UIImage.createNewImage(bgImage: tempImage!, iconImage: QRImage, iconSize: QRImage.size.width)
//    }
//    
//    /// 拼接图片
//    ///
//    /// - Parameters:
//    ///   - bgImage: 背景图片
//    ///   - iconImage: icon图片
//    ///   - iconSize: icon的大小
//    private class func createNewImage(bgImage: UIImage, iconImage:UIImage, iconSize:CGFloat) -> UIImage? {
//        UIGraphicsBeginImageContext(bgImage.size)
//        bgImage.draw(in: CGRect(x: 0, y: 0, width: bgImage.size.width, height: bgImage.size.height))
//        let imageX: CGFloat = (bgImage.size.width - iconSize) * 0.5
//        let imageY: CGFloat = (bgImage.size.height - iconSize) * 0.5
//        iconImage.draw(in: CGRect(x: imageX, y: imageY, width: iconSize, height: iconSize))
//        let result = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return result
//    }
//    
//    /// 剪切圆形图片
//    ///
//    /// - Parameter image: 需要剪裁的图片
//    /// - Returns: 处理好的图片
//    private class func createCircularImage(image: UIImage) -> UIImage?{
//        UIGraphicsBeginImageContextWithOptions(image.size, false, 0)
//        let ctx = UIGraphicsGetCurrentContext()
//        ctx?.addEllipse(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
//        ctx?.clip()
//        image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
//        let result = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return result
//    }
//    
//    
//    
//    /// 根据CIImage生成指定大小的图片
//    ///
//    /// - Parameters:
//    ///   - image: CIImage
//    ///   - size: 图片大小
//    /// - Returns: 图片
//    private class func createNonInterpolatedUIImage(image: CIImage, size: CGFloat) -> UIImage? {
//        let extent = image.extent.integral
//        let scale = min(size/extent.width, size/extent.height)
//        let width = extent.width * scale
//        let height = extent.height * scale
//        let cs = CGColorSpaceCreateDeviceGray()
//        
//        let context = CIContext(options: nil);
//        let bitmapImage = context.createCGImage(image, from: extent)
//        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.none.rawValue)
//        guard let bitmapRef = CGContext(data: nil,width: Int(width),height: Int(height),bitsPerComponent: 8,bytesPerRow: 0,space: cs,bitmapInfo: bitmapInfo.rawValue)else {
//            return nil;
//        }
//        
//        bitmapRef.interpolationQuality = CGInterpolationQuality.none
//        bitmapRef.scaleBy(x: scale,y: scale)
//        bitmapRef.draw(bitmapImage!, in: extent)
//        
//        guard let scaledImage = bitmapRef.makeImage() else {
//            return nil;
//        }
//        
//        return UIImage(cgImage: scaledImage)
//    }
//    
//    
//    
//    /// 把图片按比例缩放
//    ///
//    /// - Parameters:
//    ///   - sourceImage: 需要处理的图片
//    ///   - size: 显示到多大的区域
//    /// - Returns: 处理好的图片
//    private class func imageCompress(sourceImage: UIImage, size:CGSize) -> UIImage? {
//        let imageSize = sourceImage.size
//        let width = imageSize.width
//        let height = imageSize.height
//        let targetWidth = size.width
//        let targetHeight = size.height
//        var scaleFactor:CGFloat = 0
//        var scaledWidth = targetWidth
//        var scaledHeight = targetHeight
//        var thumbnailPoint = CGPoint(x: 0, y: 0)
//        if !__CGSizeEqualToSize(imageSize, size) {
//            let widthFactor:CGFloat = CGFloat(targetWidth / width)
//            let heightFactor:CGFloat = CGFloat(targetHeight / height)
//            
//            if(widthFactor > heightFactor){
//                scaleFactor = widthFactor
//                
//            }
//            else{
//                
//                scaleFactor = heightFactor
//            }
//            scaledWidth = width * scaleFactor
//            scaledHeight = height * scaleFactor
//            
//            if(widthFactor > heightFactor){
//                
//                thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
//            }else if(widthFactor < heightFactor){
//                
//                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
//            }
//        }
//        
//        UIGraphicsBeginImageContext(size)
//        
//        let thumbnailRect = CGRect(origin: thumbnailPoint, size: CGSize(width: scaledWidth, height: scaledHeight))
//        
//        sourceImage.draw(in: thumbnailRect)
//        let result = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return result
//    }
//    
//}
//
//class AVCaptureSessionManager: AVCaptureSession, AVCaptureMetadataOutputObjectsDelegate {
//    
//    /// 音效名称
//    var soundName:String?
//    /// 是否播放音效
//    var isPlaySound = false
//    
//    private var block: SuccessBlock?
//    
//    private lazy var device: AVCaptureDevice = {
//       return AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
//    }()
//    
//    private lazy var preViewLayer: AVCaptureVideoPreviewLayer = {
//        return AVCaptureVideoPreviewLayer(session: self)
//    }()
//    
//    
//   /// 创建sessionManager
//   ///
//   /// - Parameters:
//   ///   - captureType: 需要扫描的类型
//   ///   - scanRect: 扫描区域这里的Rect(x,y,w,h)分别的取值范围都是0-1 如果需要全屏传入React.null
//   ///   - success: 成功回调
//   convenience init(captureType: AVCaptureType,
//                    scanRect: CGRect,
//                    success: @escaping SuccessBlock) {
//        self.init()
//        block = success
//    
//        var input: AVCaptureDeviceInput?
//        do {
//            input = try AVCaptureDeviceInput(device: device)
//        } catch let error as NSError {
//            print("AVCaputreDeviceError \(error)")
//        }
//        
//        let output = AVCaptureMetadataOutput()
//        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
//        
//        if !scanRect.equalTo(CGRect.null) {
//            output.rectOfInterest = scanRect
//        }
//        
//        sessionPreset = AVCaptureSessionPresetHigh
//        if canAddInput(input) {
//            addInput(input)
//        }
//        
//        if canAddOutput(output) {
//            addOutput(output)
//        }
//        output.metadataObjectTypes = captureType.supportTypes()
//        NotificationCenter.default.addObserver(self,
//                                               selector: #selector(stop),
//                                               name: NSNotification.Name.UIApplicationDidEnterBackground,
//                                               object: nil)
//        
//        NotificationCenter.default.addObserver(self,
//                                               selector: #selector(start),
//                                               name: NSNotification.Name.UIApplicationWillEnterForeground,
//                                               object: nil)
//    
//    }
//    
//    
//    /// 创建sessionManager
//    ///
//    /// - Parameters:
//    ///   - captureType: 需要扫描的类型
//    ///   - scanRect: 扫描区域这里的Rect(x,y,w,h)分别的取值范围都是0-1 如果需要全屏传入React.null
//    ///   - success: 成功回调
//    /// - Returns: manager
//    class func createSessionManager(captureType: AVCaptureType,
//                                    scanRect: CGRect,
//                                    success: @escaping SuccessBlock) ->AVCaptureSessionManager {
//        let result = AVCaptureSessionManager(captureType: captureType, scanRect: scanRect, success: success);
//        return result
//    }
//    
//
//    /// 监测相机权限
//    ///
//    /// - Parameters:
//    ///   - grant: 同意回调
//    ///   - denied: 拒绝回调
//    class func checkAuthorizationStatusForCamera(grant:@escaping GrantBlock, denied:DeniedBlock) {
//        
//        if let device = AVCaptureDevice.devices(withMediaType: AVMediaTypeVideo) {
//            let status = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
//            switch status {
//            case .notDetermined:
//                AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo, completionHandler: { (granted) in
//                    if granted {
//                        DispatchQueue.main.async(execute: {
//                            grant()
//                        })
//                    }
//                })
//            case .authorized:
//                grant()
//            case .denied:
//                denied()
//            default:
//                break
//            }
//        }
//    }
//    
//    /// 监测相册权限
//    ///
//    /// - Parameters:
//    ///   - grant: 同意回调
//    ///   - denied: 拒绝回调
//    class func checkAuthorizationStatusForPhotoLibrary(grant:@escaping GrantBlock, denied:DeniedBlock) {
//        let status = PHPhotoLibrary.authorizationStatus()
//        switch status {
//        case .notDetermined:
//            PHPhotoLibrary.requestAuthorization({ (status) in
//                if status == PHAuthorizationStatus.authorized {
//                    DispatchQueue.main.async(execute: {
//                        grant()
//                    })
//                }
//            })
//            
//        case .authorized:
//            grant()
//        case .denied:
//            denied()
//        default:
//            break
//        }
//    }
//    
//    /// 扫描相册中的二维码
//    ///
//    /// - Parameters:
//    ///   - image: 图片
//    ///   - success: 成功回调
//    func scanPhoto(image: UIImage, success: SuccessBlock) {
//        let detector = CIDetector(ofType: CIDetectorTypeQRCode,
//                                  context: nil,
//                                  options: [CIDetectorAccuracy : CIDetectorAccuracyHigh])
//        if detector != nil {
//            let features = detector!.features(in: CIImage(cgImage: image.cgImage!))
//            for temp in features {
//                let result = (temp as! CIQRCodeFeature).messageString
//                success(result)
//                return
//            }
//            success(nil)
//        }else {
//            success(nil)
//        }
//        
//    }
//    
//    /// 显示扫描
//    ///
//    /// - Parameter view: 需要在哪个View中显示
//    func showPreViewLayerIn(view :UIView) {
//        preViewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
//        preViewLayer.frame = view.bounds
//        view.layer.insertSublayer(preViewLayer, at: 0)
//        start()
//    }
//    
//    
//    /// 开关闪光灯
//    ///
//    /// - Parameter state: 闪光灯状态
//    func turnTorch(state:Bool) {
//        if (device.hasTorch) {
//            do {
//                try device.lockForConfiguration()
//            } catch let error as NSError {
//                print("TorchError  \(error)")
//            }
//            if (state) {
//                device.torchMode = AVCaptureTorchMode.on
//            } else {
//                device.torchMode = AVCaptureTorchMode.off
//            }
//            device.unlockForConfiguration()
//        }
//    }
//    
//    
//    /// 播放音效
//    func playSound() {
//        if isPlaySound {
//            var result = "ZZYQRCode.bundle/sound.caf"
//            if let temp = soundName, temp != ""{
//                result = temp
//            }
//            
//            if let urlstr = Bundle.main.path(forResource: result, ofType: nil) {
//                let fileURL = NSURL(fileURLWithPath: urlstr)
//                var soundID:SystemSoundID = 0;
////                AudioServicesCreateSystemSoundID(fileURL, &soundID)
//                AudioServicesPlaySystemSound(soundID)
//            }
//        }
//    }
//    
//    /// 开启扫描
//    func start() {
//        startRunning()
//    }
//    
//    /// 停止扫描
//    func stop() {
//        stopRunning()
//    }
//    
//    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
//        if (metadataObjects.count > 0) {
//            // 停止扫描
//            stop()
//            playSound()
//            // 获取信息
//            let result = metadataObjects.last as! AVMetadataMachineReadableCodeObject
//            block!(result.stringValue)
//        }
//    }
//}
//
//enum AVCaptureType {
//    case AVCaptureTypeQRCode
//    case AVCaptureTypeBarCode
//    case AVCaptureTypeBoth
//    func supportTypes() -> [String] {
//        switch self {
//        case .AVCaptureTypeQRCode:
//            return [AVMetadataObjectTypeQRCode]
//        case .AVCaptureTypeBarCode:
//            return [AVMetadataObjectTypeDataMatrixCode,
//                    AVMetadataObjectTypeITF14Code,
//                    AVMetadataObjectTypeInterleaved2of5Code,
//                    AVMetadataObjectTypeAztecCode,
//                    AVMetadataObjectTypePDF417Code,
//                    AVMetadataObjectTypeCode128Code,
//                    AVMetadataObjectTypeCode93Code,
//                    AVMetadataObjectTypeEAN8Code,
//                    AVMetadataObjectTypeEAN13Code,
//                    AVMetadataObjectTypeCode39Mod43Code,
//                    AVMetadataObjectTypeCode39Code,
//                    AVMetadataObjectTypeUPCECode]
//        case .AVCaptureTypeBoth:
//            return [AVMetadataObjectTypeQRCode,
//                    AVMetadataObjectTypeDataMatrixCode,
//                    AVMetadataObjectTypeITF14Code,
//                    AVMetadataObjectTypeInterleaved2of5Code,
//                    AVMetadataObjectTypeAztecCode,
//                    AVMetadataObjectTypePDF417Code,
//                    AVMetadataObjectTypeCode128Code,
//                    AVMetadataObjectTypeCode93Code,
//                    AVMetadataObjectTypeEAN8Code,
//                    AVMetadataObjectTypeEAN13Code,
//                    AVMetadataObjectTypeCode39Mod43Code,
//                    AVMetadataObjectTypeCode39Code,
//                    AVMetadataObjectTypeUPCECode]
//        }
//    }
//}

