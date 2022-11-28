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

        var list = LinkedList(1,2,3)
        list.append(value: 4)
        list[2] = 8
        list[4] = 9
        print(list)
        list.remove(at: 4)
        print(list)
    }
}

