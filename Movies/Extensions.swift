//
//  Extensions.swift
//  Movies
//
//  Created by Dane Jordan on 4/30/17.
//  Copyright © 2017 Dane Jordan. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    var contentViewController: UIViewController {
        if let navCon = self as? UINavigationController {
            return navCon.visibleViewController ?? self
        }
        return self
    }
}

class Utils {
    class func genLoadingScreen(_ width: CGFloat, height: CGFloat, loadingText: String) -> UIView {
        let indicatorWidth:CGFloat = 20
        let indicatorHeight:CGFloat = 20
        
        let backgroundLoadingView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        backgroundLoadingView.backgroundColor = .white
        
        let indicatorFrame = CGRect(x: (width - indicatorWidth) / 2, y: height  / 2 - indicatorHeight - 10, width: indicatorWidth, height: indicatorHeight)
        let loadingIndicator = UIActivityIndicatorView(frame: indicatorFrame)
        let loadingFrame = CGRect(x: 0, y: indicatorHeight, width: width, height: height)
        let loadingLabel = UILabel(frame: loadingFrame)
        
        loadingLabel.text = loadingText
        loadingLabel.numberOfLines = 0
        loadingLabel.font = UIFont(name: "Avenir-Book", size: 12)
        loadingLabel.textColor = .black
        loadingLabel.textAlignment = .center
        loadingIndicator.color = .black 
        loadingIndicator.startAnimating()
        
        return backgroundLoadingView
    }
}
