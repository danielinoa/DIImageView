//
//  ViewController.swift
//  DIImageView
//
//  Created by Daniel Inoa on 4/2/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import DIImageView

final class ViewController: UIViewController {
    
    override func loadView() {
        let image = UIImage(named: "alley")
        let imageView = DIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        view = imageView
    }
    
}
