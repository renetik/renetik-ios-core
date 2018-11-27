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

    override func viewDidLoad() {
        super.viewDidLoad()
        CSMessage().title("Some message test").show(self)
    }

}

