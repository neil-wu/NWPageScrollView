//
//  ViewController.swift
//  NWPageScrollViewDemo
//
//  Created by neilwu on 6/11/15.
//  Copyright © 2015年 neilwu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var topView: TopView!
    @IBOutlet weak var botView: BotView!
    @IBOutlet weak var topViewHeightConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "NWPageScrollViewDemo"
        self.automaticallyAdjustsScrollViewInsets = false
        
        let maxW = UIScreen.mainScreen().bounds.width
        let maxH = self.topViewHeightConstraint.constant
        //print(maxW, maxH)
        let maxSize = CGSizeMake(maxW, maxH)
        self.topView.initTopViewPage(maxSize)
        self.botView.initBotViewPage(maxSize)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

