//
//  QRCodeViewController.swift
//  20150623_01_WeBlog
//
//  Created by lincy on 15/6/29.
//  Copyright © 2015年 lincy. All rights reserved.
//

import UIKit
import AVFoundation

class QRCodeViewController: UIViewController,AVCaptureMetadataOutputObjectsDelegate {
    
    @IBOutlet weak var scanView: UIView!
    @IBOutlet weak var scanLineBottomConstrain: NSLayoutConstraint!
    
    @IBAction func onCloseBarBtnClicked(sender: UIBarButtonItem) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }


    override func viewDidLoad() {
        super.viewDidLoad()

//        self.scanLineBottomConstrain.constant = -20
//        self.scanView.layoutIfNeeded()
        setupQRSession()
        setupLayers()
    }
    
    override func viewDidAppear(animated: Bool) {
        startScanLineAnimation()
        startScan()
    }
    
    func startScanLineAnimation() {
        
        UIView.animateWithDuration(2.0) { () -> Void in
            // 重复次数需要放在内部
            UIView.setAnimationRepeatCount(MAXFLOAT)
            self.scanLineBottomConstrain.constant = 2 * self.scanView.bounds.height
            self.scanView.layoutIfNeeded()
        }
    }
    
    ///  开始扫描
    func startScan() {
        session.startRunning()
    }
    
    private func setupQRSession() {
        // 1. 判断能否添加输入设备
        if !session.canAddInput(inputDevice) {
            print("无法添加输入设备")
            return
        }
        
        // 2. 判断能否添加输出数据
        if !session.canAddOutput(outputData) {
            print("无法添加输出数据")
            return
        }
        
        // 3. 添加设备
        session.addInput(inputDevice)
        print("前 \(outputData.availableMetadataObjectTypes)")
        session.addOutput(outputData)
        // 只有添加到 session 之后，输出数据的数据类型才可用
        print("后 \(outputData.availableMetadataObjectTypes)")
        
        // 4. 设置检测数据类型，检测所有支持的数据格式
        outputData.metadataObjectTypes = outputData.availableMetadataObjectTypes
        
        // 5. 设置数据的代理
        outputData.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
    }
    
    // 扫描的代理方法
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        
        //扫描结果
        print(metadataObjects)
        
    }
    
    ///  设置图层
    private func setupLayers() {
        
        // 1. 预览图层－设定图层大小
        previewLayer.frame = view.bounds
        // 设置图层填充模式
        previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        // 将图层添加到当前图层
        view.layer.insertSublayer(previewLayer, atIndex: 0)
    }
    
    
    /// 懒加载
    // session 桥梁
    lazy var session: AVCaptureSession = AVCaptureSession()
    // 输入设备
    lazy var inputDevice: AVCaptureDeviceInput? = {
        // 取摄像头设备
        let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        
        do {
            return try AVCaptureDeviceInput(device: device)
        } catch {
            print(error)
            return nil
        }
    }()
    // 输出数据
    lazy var outputData: AVCaptureMetadataOutput = AVCaptureMetadataOutput()

    // 预览视图 - 依赖与session的
    lazy var previewLayer: AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.session)
    
    deinit {
        print("\(self)88")
    }

}
