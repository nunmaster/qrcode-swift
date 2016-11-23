//
//  ViewController.swift
//  spike-qrcode
//
//  Created by Nonthanun Sudlapa on 11/18/2559 BE.
//  Copyright © 2559 nun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var qrCodeLabel: UILabel!
    @IBOutlet var qrCodeImageView: UIImageView!
    @IBOutlet var qrCodeIcon: UIImageView!
    @IBOutlet var qrCodeTextFIeld: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func unwind(unwindSegue: UIStoryboardSegue) {
        if let viewController = unwindSegue.source as? ScannerViewController {
            self.qrCodeLabel.text = viewController.qrString
        }
    }
    
    @IBAction func qrCodeButtonDidTouch(_ sender: Any) {
        self.view.endEditing(true)
        self.showQRCodeFromStr(qrString: self.qrCodeTextFIeld.text!)
    }
    
    func showQRCodeFromStr(qrString: String) {
        if let qrImage = createQRFromString(qrString: qrString) {
            
            // show tmn logo on qrcode
            self.qrCodeIcon.image = UIImage(named: "logo-wallet")
            self.qrCodeIcon.backgroundColor = UIColor.white
            
            let scaleX = self.qrCodeImageView.frame.size.width / qrImage.extent.size.width
            let scaleY = self.qrCodeImageView.frame.size.height / qrImage.extent.size.height
            let qrImageRescale = qrImage.applying(CGAffineTransform(scaleX: scaleX, y: scaleY))
            self.qrCodeImageView.image = UIImage(ciImage: qrImageRescale)
        }
    }
    
    func createQRFromString(qrString: String) -> CIImage? {
        let stringData = qrString.data(using: String.Encoding.utf8)
        let filter = CIFilter(name: "CIQRCodeGenerator")!
        filter.setValue(stringData, forKey: "inputMessage")
        filter.setValue("H", forKey: "inputCorrectionLevel")
        
        return filter.outputImage
    }
}

