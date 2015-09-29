//
//  ViewController.swift
//  SwiftTest
//
//  Created by Max on 15/9/24.
//  Copyright (c) 2015年 Max. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var dictory : NSMutableDictionary?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        dictory = NSMutableDictionary.new();
        dictory!.setValue(1, forKey: "bbb");
        println(dictory?.valueForKey("bbb")?.superclass);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
    }


}

