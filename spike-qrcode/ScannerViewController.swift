//
//  ScannerViewController.swift
//  spike-qrcode
//
//  Created by Nonthanun Sudlapa on 11/18/2559 BE.
//  Copyright © 2559 nun. All rights reserved.
//

import UIKit
import MTBBarcodeScanner

class ScannerViewController: UIViewController {
    
    var scanner: MTBBarcodeScanner?
    var qrString: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scanner = MTBBarcodeScanner(previewView: self.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.scanner?.startScanning(resultBlock: { codes in
            let codeObjects = codes as! [AVMetadataMachineReadableCodeObject]?
            for code in codeObjects! {
                self.qrString = code.stringValue!
                self.performSegue(withIdentifier: "backToMain", sender: self)
                self.dismiss(animated: true, completion: nil)
            }
            
        }, error: nil)
    }
    
    @IBAction func flashSwitchDIdChange(_ sender: Any) {
        if (scanner?.torchMode.rawValue == 0) {
            scanner?.torchMode = .on
        } else {
            scanner?.torchMode = .off
        }
    }
    
}
