//
//  ViewController.swift
//  testingSnapchatCamera
//
//  Created by Grigory Rudko on 9/5/16.
//  Copyright © 2016 Grigory Rudko. All rights reserved.
//


import UIKit
import AVFoundation
//import Foundation


class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate  {
   
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var twoPersons: UILabel!
    @IBOutlet weak var threePersons: UILabel!
    @IBOutlet weak var fourPersons: UILabel!
    @IBOutlet weak var fivePersons: UILabel!
    

        
    
    @IBAction func onTap(sender: AnyObject) {
        self.textField.resignFirstResponder()
        self.tipControl.resignFirstResponder()
    }

   
        
    
    
    
    
    @IBAction func calculateTip(sender: AnyObject) {

        let bill = Double(billField.text!) ?? 0
        
        
        
       /* guard tipControl.selectedSegmentIndex >= 0 else {
        totalLabel.text = String(format: "$%.2f", bill)
            return
        } */
        
    
        let tipPercentages = [0.18, 0.2, 0.25]
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        
        let twoTip = (bill + tip) / 2
        let threeTip = (bill + tip) / 3
        let fourTip = (bill + tip) / 4
        let fiveTip = (bill + tip) / 5
        
        twoPersons.text = String(format: "$%.2f", twoTip)
        threePersons.text = String(format: "$%.2f", threeTip)
        fourPersons.text = String(format: "$%.2f", fourTip)
        fivePersons.text = String(format: "$%.2f", fiveTip)



        
        
        //self.view.endEditing(true)

        
    }
    
    
    
    
    
    var captureSession: AVCaptureSession?
    var stillImageOutput: AVCaptureStillImageOutput?
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    
    
    @IBOutlet weak var cameraView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.becomeFirstResponder()
    }

   
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        previewLayer?.frame = cameraView.bounds
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        UIStatusBarStyle.LightContent
    
        captureSession = AVCaptureSession()
        captureSession?.sessionPreset = AVCaptureSessionPreset1920x1080
        
        let backCamera = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        
        var error : NSError?
        var input: AVCaptureDeviceInput!
        do {
            input = try AVCaptureDeviceInput(device: backCamera)
        } catch let error1 as NSError {
            error = error1
            input = nil
        }
        
        if (error == nil && captureSession?.canAddInput(input) != nil){
            
            captureSession?.addInput(input)
            
            stillImageOutput = AVCaptureStillImageOutput()
            stillImageOutput?.outputSettings = [AVVideoCodecKey : AVVideoCodecJPEG]
            
            if (captureSession?.canAddOutput(stillImageOutput) != nil){
                captureSession?.addOutput(stillImageOutput)
                
                previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                previewLayer?.videoGravity = AVLayerVideoGravityResizeAspect
                previewLayer?.connection.videoOrientation = AVCaptureVideoOrientation.Portrait
                cameraView.layer.addSublayer(previewLayer!)
                captureSession?.startRunning()
                
            
        }
    }
}


   
    
    
    
    
    
    
    
    
}


















