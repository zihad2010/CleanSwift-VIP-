//
//  Loader.swift
//  CleanSwift(VIP)
//
//  Created by Steve JobsOne on 4/15/20.
//  Copyright © 2020 Steve JobsOne. All rights reserved.
//

import Foundation
import UIKit

//MARK: Loader View Model


//MARK: Loader Protocal
protocol LoaderProtocol {
    func showLoder(viewModel:ViewModel)
}

extension LoaderProtocol where Self: UIViewController{
    
    func showLoder(viewModel: ViewModel) {
        switch viewModel.showOrHide {
        case true:
            Loader.sharedInstance.showIndicator()
            break
        default:
            Loader.sharedInstance.hideIndicator()
            break
        }
    }
}

public class Loader {
    
    public static let sharedInstance = Loader()
    var blurImg = UIImageView()
    var indicator = UIActivityIndicatorView()
    
    private init()
    {
        blurImg.frame = UIScreen.main.bounds
        blurImg.backgroundColor = UIColor.brown
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
                keyWindow.addSubview(self.blurImg)
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
