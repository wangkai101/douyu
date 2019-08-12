//
//  BaseViewController.swift
//  douyu
//
//  Created by Mr wngkai on 2019/5/25.
//  Copyright © 2019 Mr wngkai. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var contentView : UIView?
    
    
    private lazy var animImageView : UIImageView = { [unowned self] in
        let imageView = UIImageView(image: UIImage(named: "img_loading_1"))
        imageView.center = self.view.center
        imageView.animationImages = [UIImage(named: "img_loading_1")!, UIImage(named: "img_loading_2")!]
        imageView.animationDuration = 0.5
        imageView.animationRepeatCount = LONG_MAX
        return imageView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
   
}


extension BaseViewController {
    func setupUI() {
        
        contentView?.isHidden = true
        
        view.addSubview(animImageView)
        
        animImageView.startAnimating()
    }
}
