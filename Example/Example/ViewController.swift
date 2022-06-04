//
//  ViewController.swift
//  Example
//
//  Created by Renetik on 04/06/22.
//

import UIKit
import Renetik

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        logInfo("test")
        view.background(color: .red).background4(dashed: .blue, stroke: 5, gap: 3)
        // Do any additional setup after loading the view.
    }


}

