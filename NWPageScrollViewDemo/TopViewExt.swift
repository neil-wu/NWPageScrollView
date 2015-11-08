//
//  TopViewExt.swift
//  NWPageScrollViewDemo
//
//  Created by neilwu on 7/11/15.
//  Copyright © 2015年 neilwu. All rights reserved.
//

import UIKit

class TopView: UIView, NWPageScrollViewDelegate {
    
    var topPageScrollView: NWPageScrollView! = nil
    var cellSize: CGSize = CGSizeZero
    var imgPathList: [String] = []
    
    func initTopViewPage(maxSize: CGSize) {
        cellSize = maxSize
        self.clipsToBounds = true
        imgPathList.append("http://images.freeimages.com/images/previews/cad/leaf-textures-1-1506285.jpg")
        imgPathList.append("http://images.freeimages.com/images/previews/05a/trevi-fountain-1213101.jpg")
        imgPathList.append("http://images.freeimages.com/images/previews/ef3/african-sunrise-1359276.jpg")
        imgPathList.append("http://images.freeimages.com/images/previews/d2c/fjord-hdr-1169486.jpg")
        
        topPageScrollView = NWPageScrollView()
        topPageScrollView.pageScrollDelegate = self
        topPageScrollView.initSetup(maxSize, cellSize: cellSize, padding: 0)
        self.addSubview(topPageScrollView)
        
        print("loading image...")
        topPageScrollView.reloadData()
    }
    
    func pageViewAtIndex(index: Int) -> UIView {
        let img = UIImageView()
        img.frame.size = self.cellSize
        img.contentMode = .ScaleAspectFill

        let image_url = NSURL(string: self.imgPathList[index])
        dispatch_async(dispatch_get_global_queue(0, 0)) { () -> Void in
            let data:NSData? = NSData(contentsOfURL : image_url!)
            if data == nil {
                return
            }
            let image = UIImage(data : data!)
            dispatch_async(dispatch_get_main_queue()) {
                img.image = image
            }
        }
        return img
    }
    
    func numberOfPage() -> Int {
        return imgPathList.count
    }

    func endScrollToIndex(index: Int) {
        print("top view, index \(index)")
    }
}

