//
//  UIColor+Extension.swift
//  Deepfakery
//
//  Created by Jasur Tursunov on 24.04.2022.
//

import UIKit

extension UIColor {
    
    static let umud = UIColor.colorWithHexString(hexString: "859F27")
    static let serik = colorWithHexString(hexString: "F4DFA8")
    
    static func colorWithHexString(hexString: String, alpha:CGFloat = 1.0) -> UIColor {
        let hexint = Int(self.intFromHexString(hexStr: hexString))
        let red = CGFloat((hexint & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hexint & 0xff00) >> 8) / 255.0
        let blue = CGFloat((hexint & 0xff) >> 0) / 255.0
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return color
    }
    
    static func intFromHexString(hexStr: String) -> UInt32 {
        var hexInt: UInt32 = 0
        let scanner: Scanner = Scanner(string: hexStr)
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        hexInt = UInt32(bitPattern: scanner.scanInt32(representation: .hexadecimal) ?? 0)
        return hexInt
    }
}
