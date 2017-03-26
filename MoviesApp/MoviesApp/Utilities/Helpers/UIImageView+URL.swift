//
//  UIImageView+URL.swift
//  MoviesApp
//
//  Created by Mireya Orta on 3/26/17.
//  Copyright © 2017 Mireya Orta. All rights reserved.
//

import UIKit
import AlamofireImage

extension UIImageView {
    
    func loadImage(with imageURL: URL, placeholderImage: UIImage?) {
        af_setImage(withURL: imageURL, placeholderImage: placeholderImage)
    }
}
