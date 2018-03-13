//
//  UIImageExtension.swift
//  RidazFramework
//
//  Created by Adrien Audouard on 23/02/2018.
//  Copyright © 2018 Adrien Audouard. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    /// Return a image scale to the new size
    ///
    /// - Parameter newSize: Size of the new image
    /// - Returns: Image scaled
    func imageWithImage(scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        self.draw(in: CGRect(origin: CGPoint.zero, size: CGSize(width: newSize.width, height: newSize.height)))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
}
