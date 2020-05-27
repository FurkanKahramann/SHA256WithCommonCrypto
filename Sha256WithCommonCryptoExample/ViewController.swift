//
//  ViewController.swift
//  Sha256WithCommonCryptoExample
//
//  Created by Furkan Kahraman on 27.05.2020.
//  Copyright © 2020 Furkan Kahraman. All rights reserved.
//

import UIKit
import CommonCrypto
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let clearString = "test"
        
        let hashName = clearString.sha256()
        
        print("HashName: \(hashName)")
        // Do any additional setup after loading the view.
    }


}
extension String {

    func sha256() -> String{
        if let stringData = self.data(using: String.Encoding.utf8) {
            return hexStringFromData(input: digest(input: stringData as NSData))
        }
        return ""
    }

    private func digest(input : NSData) -> NSData {
        let digestLength = Int(CC_SHA256_DIGEST_LENGTH)
        var hash = [UInt8](repeating: 0, count: digestLength)
        CC_SHA256(input.bytes, UInt32(input.length), &hash)
        return NSData(bytes: hash, length: digestLength)
    }

    private  func hexStringFromData(input: NSData) -> String {
        var bytes = [UInt8](repeating: 0, count: input.length)
        input.getBytes(&bytes, length: input.length)

        var hexString = ""
        for byte in bytes {
            hexString += String(format:"%02x", UInt8(byte))
        }

        return hexString
    }

}

