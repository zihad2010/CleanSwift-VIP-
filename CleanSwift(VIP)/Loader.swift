//
//  Loader.swift
//  CleanSwift(VIP)
//
//  Created by Steve JobsOne on 4/15/20.
//  Copyright © 2020 Steve JobsOne. All rights reserved.
//

import Foundation
import UIKit

public class Loader {
    
    public static let sharedInstance = Loader()
    var blurImg = UIImageView()
    var indicator = UIActivityIndicatorView()
    
    private init()
    {
        blurImg.frame = UIScreen.main.bounds
        blurImg.backgroundColor = UIColor.black
        blurImg.isUserInteractionEnabled = true
        blurImg.alpha = 0.5
        indicator.style = .large
        indicator.center = blurImg.center
        indicator.startAnimating()
        indicator.color = .gray
    }
    
    func showIndicator(){
        DispatchQueue.main.async( execute: {
            if let keyWindow = UIWindow.key {
               // keyWindow.addSubview(self.blurImg)
                keyWindow.addSubview(self.indicator)
            }
        })
    }
    func hideIndicator(){
        
        DispatchQueue.main.async( execute: {
            self.blurImg.removeFromSuperview()
            self.indicator.removeFromSuperview()
        })
    }
}

extension UIWindow {
   
    static var key: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}
