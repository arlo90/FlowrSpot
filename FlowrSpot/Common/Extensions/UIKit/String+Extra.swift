//
//  String+Extra.swift
//  FlowrSpot
//
//  Created by Arijan Ljoki on 27/07/2019.
//  Copyright © 2019 PovioLabs. All rights reserved.
//

import UIKit

extension String {
    func addIcon(icon: String, size: CGSize) -> NSAttributedString {
        let iconImage = UIImage(named: icon)
        
        return self.addIcon(iconImage: iconImage!, size: size)
    }
    
    func addIcon(iconImage: UIImage, size: CGSize) -> NSAttributedString {
        let attributedString = NSMutableAttributedString()
        
        let attachmenIcon = NSTextAttachment()
        attachmenIcon.image = resizeImage(image: iconImage, targetSize: size)
        let attachmentString = NSAttributedString(attachment: attachmenIcon)
        let attributed = NSMutableAttributedString(string: " " + self)
        attributedString.append(attachmentString)
        attributedString.append(attributed)
        
        return attributedString
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if widthRatio > heightRatio {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}
