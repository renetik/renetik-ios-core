//
//  ViewController.swift
//  Example for Renetik IOS
//
//  Created by Rene on 11/26/18.
//  Copyright © 2018 rene-dohan. All rights reserved.
//

import UIKit
import Renetik

class ViewController: UIViewController {
    
    override func loadView() {
        view = UIView().construct().width(200, height: 400).back(.green)
        view.add(UILabel().construct()).flexibleLeft().top(50).height(30).back(.blue).width(100).fromRight(10)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CSMessage().title("Some message test").show(self)
    }

}

