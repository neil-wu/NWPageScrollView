//
//  BotViewExt.swift
//  NWPageScrollViewDemo
//
//  Created by neilwu on 7/11/15.
//  Copyright © 2015年 neilwu. All rights reserved.
//

import UIKit

class BotView: UIView, NWPageScrollViewDelegate {
    
    var botPageScrollView: NWPageScrollView! = nil
    var cellSize: CGSize = CGSizeZero
    
    let maxCellNum: Int = 4
    
    func initBotViewPage(maxSize: CGSize) {
        cellSize = CGSizeMake(maxSize.width - 30, maxSize.height - 30)
        
        self.clipsToBounds = true
        
        botPageScrollView = NWPageScrollView()
        botPageScrollView.pageScrollDelegate = self
        botPageScrollView.initSetup(maxSize, cellSize: cellSize, padding: 8)
        self.addSubview(botPageScrollView)
        
        botPageScrollView.reloadData()
    }
    
    func pageViewAtIndex(index: Int) -> UIView {
        let cell = NSBundle.mainBundle().loadNibNamed("CustomCell", owner: self, options: nil).first as! CustomCellView
        cell.titleLabel.text = "Cell \(index + 1)"
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 8
        cell.frame.size = self.cellSize
        
        return cell
    }
    
    func numberOfPage() -> Int {
        return maxCellNum
    }
    
    func endScrollToIndex(index: Int) {
        print("bot view, index \(index)")
    }

}

