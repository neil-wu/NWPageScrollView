//
//  NWPageScrollView.swift
//  neilwu
//
//  Created by neilwu on 15/10/28.
//  Copyright © 2015年 neilwu. All rights reserved.
//

import UIKit

@objc protocol NWPageScrollViewDelegate : class {
    func pageViewAtIndex(index: Int) -> UIView
    func numberOfPage() -> Int
    
    optional func endScrollToIndex(index: Int)
}

class NWPageScrollView: UIScrollView, UIScrollViewDelegate {

    private var containerSize: CGSize = CGSizeZero
    private var cellSize: CGSize = CGSizeZero
    private var padding: CGFloat = 5 //cell padding
    
    private var selectedIndex: Int = -1
    private var allCells: [UIView] = []
    
    weak var pageScrollDelegate: NWPageScrollViewDelegate!
    
    /*
    Setup the NWPageScrollView
    @param containerSize: the max size of NWPageScrollView's root view
    @param cellSize: size of one cell
    @param padding: horizonal space between cells
    */
    func initSetup(containerSize: CGSize, cellSize: CGSize, padding: CGFloat = 5) {
        self.containerSize = containerSize
        self.cellSize = cellSize
        self.padding = padding
        
        var frame: CGRect = CGRectZero
        frame.origin.x = (containerSize.width - cellSize.width ) * 0.5
        frame.origin.y = (containerSize.height - cellSize.height ) * 0.5
        frame.size.width = cellSize.width + self.padding // Here we set scroll view's bounds equal to cell' width and padding
        frame.size.height = cellSize.height
        self.frame = frame

        // Based on this trick, pay attention that the scroll view stops
        // on multiples of the scroll view's bounds when the user scrolls.
        self.pagingEnabled = true
        
        self.clipsToBounds = false // do not clip to bounds
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        self.autoresizesSubviews = false
        self.multipleTouchEnabled = false
        self.decelerationRate = UIScrollViewDecelerationRateFast;
        self.delegate = self // UIScrollViewDelegate
        
    }
    
    /*
    reload data
    @param stopAtIndex: which index of cell do you want to show after reload done.
    */
    func reloadData(stopAtIndex: Int = 0) {
        guard self.pageScrollDelegate != nil else {
            return
        }
        
        allCells.removeAll()
        _ = self.subviews.map{ $0.removeFromSuperview() }
        
        var startX: CGFloat = 0
        
        let numberOfPage = pageScrollDelegate.numberOfPage()
        
        for index in 0 ..< numberOfPage {
            let cell = pageScrollDelegate.pageViewAtIndex(index)
            cell.frame = CGRectMake(startX, 0, cellSize.width, cellSize.height)
            self.addSubview(cell)
            
            startX = startX + self.padding + cellSize.width
            allCells.append(cell)
        }
        
        let scrollViewSizeWidth: CGFloat = startX - self.padding + (self.frame.width - self.cellSize.width) * 0.5
        
        self.contentSize = CGSizeMake(scrollViewSizeWidth, self.cellSize.height )
        self.scrollToIndex(stopAtIndex, animateScroll: false)
    }
    
    /*
    @param scrollToIndex: cell index
    @param animateScroll: animate scroll to the cell
    */
    func scrollToIndex(index: Int, animateScroll: Bool = true)  {
        if index < 0 || index >= self.allCells.count {
            return
        }
        
        let destPt = CGPointMake((self.cellSize.width + self.padding) * CGFloat(index), 0)
        if animateScroll {
            UIView.animateWithDuration(0.3, animations: { [weak self] () -> Void in
                self?.setContentOffset(destPt, animated: true)
                }, completion: { [weak self] (isDone) -> Void in
                    if isDone {
                        self?.onScrollToIndex(index)
                    }
            })
        } else {
            self.setContentOffset(destPt, animated: true)
            self.onScrollToIndex(index)
        }
        
    }

    //delegate interface of UIScrollView
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let index: Int = Int((scrollView.contentOffset.x + self.frame.origin.x) / scrollView.frame.size.width)
        self.onScrollToIndex(index)
    }

    private func onScrollToIndex(index: Int) {
        if index < 0 || index >= self.allCells.count {
            return
        }
        if self.selectedIndex == index {
            return
        }
        self.selectedIndex = index
        self.pageScrollDelegate?.endScrollToIndex?(index)
    }
    
}







