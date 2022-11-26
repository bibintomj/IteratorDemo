//
//  ViewController.swift
//  IteratorDemo
//
//  Created by Bibin Tom Joseph on 26/11/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let linkedList = LinkedList(1,2,3)
        for value in linkedList {
            print(value)
        }
    }
}

