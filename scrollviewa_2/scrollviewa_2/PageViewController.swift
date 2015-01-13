//
//  ViewController.swift
//  scrollView
//
//  Created by andyhu on 15/1/12.
//  Copyright (c) 2015年 andyhu. All rights reserved.
//

import UIKit

class PageViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var pageControl: UIPageControl!
    
    
    var pageImages: [UIImage] = []
    var pageViews: [UIImageView?] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1
        pageImages.append(UIImage(named: "photo1.png")!)
        pageImages.append(UIImage(named: "photo2.png")!)
        pageImages.append(UIImage(named: "photo3.png")!)
        pageImages.append(UIImage(named: "photo4.png")!)
        pageImages.append(UIImage(named: "photo5.png")!)

        let pageCount = pageImages.count
        
        // 2
        pageControl.currentPage = 0
        pageControl.numberOfPages = 5
        
        // 3
        for _ in 0..<pageCount {
            pageViews.append(nil)
        }
        
        // 4
        let pagesScrollViewSize = scrollView.frame.size
        scrollView.contentSize = CGSize(width: pagesScrollViewSize.width * CGFloat(pageImages.count),
            height: pagesScrollViewSize.height)
        
        // 5
        loadVisiblePages()
    }
    
    func loadPage(page: Int) {
        if page < 0 || page >= pageImages.count {
            // 如果超出了页面显示的范围，什么也不需要做
            return
        }
        
        // 1
        if let pageView = pageViews[page] {
            // 页面已经加载，不需要额外操作
        } else {
            // 2
            var frame = scrollView.bounds
            frame.origin.x = frame.size.width * CGFloat(page)
            frame.origin.y = 0.0
            
            // 3
            let newPageView = UIImageView(image: pageImages[page])
            newPageView.contentMode = .ScaleAspectFit
            newPageView.frame = frame
            scrollView.addSubview(newPageView)
            
            // 4
            pageViews[page] = newPageView
        }
    }
    
    
    func purgePage(page: Int) {
        
        if page < 0 || page >= pageImages.count {
            // 如果超出要显示的范围，什么也不做
            return
        }
        
        // 从scrollView中移除页面并重置pageViews容器数组响应页面
        if let pageView = pageViews[page] {
            pageView.removeFromSuperview()
            pageViews[page] = nil
        }
    }
    
    func loadVisiblePages() {
        // 首先确定当前可见的页面
        let pageWidth = scrollView.frame.size.width
        let page = Int(floor((scrollView.contentOffset.x * 2.0 + pageWidth) / (pageWidth * 2.0)))
        
        // 更新pageControl
        pageControl.currentPage = page
        
        // 计算那些页面需要加载
        var firstPage = page - 1
        var lastPage = page + 1
       
        println("firtPage: \(firstPage) lastPage\(lastPage)")
        // 清理firstPage之前的所有页面
        for var index = 0; index < firstPage; ++index {
            purgePage(index)
        }
        
        // 加载范围内（firstPage到lastPage之间）的所有页面
        for index in firstPage...lastPage {
            loadPage(index)
        }
        
        // 清理lastPage之后的所有页面
        for var index = lastPage+1; index < pageImages.count; ++index {
            purgePage(index)
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView!) {
        // Load the pages that are now on screen
        loadVisiblePages()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

