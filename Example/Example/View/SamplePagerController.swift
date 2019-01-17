//
// Created by Rene on 2019-1-17.
// Copyright (c) 2018 Renetik Software. All rights reserved.
//

import UIKit
import Renetik

class SamplePagerController: UIViewController {

    override func loadView() {
        view = UIView().construct().width(200, height: 400).back(.green)
        view.add(UILabel().construct()).flexibleLeft().top(50).height(30).back(.blue).width(100).fromRight(10)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CSMessage().title("Some message test").show(self)
    }
}

