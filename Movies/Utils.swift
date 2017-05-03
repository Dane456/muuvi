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
    var contentViewController: UIViewController{
        if let navCon = self as? UINavigationController {
            return navCon.visibleViewController ?? self
        }
        return self
    }
}

class Utils {
    class func loadImage(forView oldView: UIImageView, path: URL, completion: @escaping (UIImageView) -> Void) {
        let view = oldView
        DispatchQueue.global(qos: .userInitiated).async {
            if let posterImage = try? UIImage(data: Data(contentsOf: path)) {
                Store.imageCache.setObject(posterImage as AnyObject, forKey: path as AnyObject)
                DispatchQueue.main.async {
                    view.image = posterImage
                    completion(view)
                }
            } else {
                print("Poster with url \(path) could not be fetched")
            }
        }
    }
}
