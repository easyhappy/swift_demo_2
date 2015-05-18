//
//  ViewController.swift
//  scrollView
//
//  Created by andyhu on 15/1/12.
//  Copyright (c) 2015年 andyhu. All rights reserved.
//

import UIKit

class PeekViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var pageControl: UIPageControl!
    
    
    var pageImages: [UIImage] = []
    var pageViews: [UIImageView?] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置需要滚动和缩放的图片
        pageImages.append(UIImage(named: "photo1.png")!)
        pageImages.append(UIImage(named: "photo2.png")!)
        pageImages.append(UIImage(named: "photo3.png")!)
        pageImages.append(UIImage(named: "photo4.png")!)
        pageImages.append(UIImage(named: "photo5.png")!)
        
        let pageCount = pageImages.count
        
        // 设置pageControl
        pageControl.currentPage = 0
        pageControl.numberOfPages = pageCount
        
        // 设置保存每个页面的view的数组
        for _ in 0..<pageCount {
            pageViews.append(nil)
        }
        
        // 设置scroll view的内容尺寸
        let pagesScrollViewSize = scrollView.frame.size
        scrollView.contentSize = CGSizeMake(pagesScrollViewSize.width * CGFloat(pageImages.count), pagesScrollViewSize.height)
        
        // 加载屏幕上的初始页面
        loadVisiblePages()
    }
    
    func loadVisiblePages() {
        // 首先确定当前可见页面
        let pageWidth = scrollView.frame.size.width
        let page = Int(floor((scrollView.contentOffset.x * 2.0 + pageWidth) / (pageWidth * 2.0)))
        
        // 更新pageControl
        pageControl.currentPage = page
        
//        // 计算哪些页面需要加载
//        let firstPage = page - 1
//        let lastPage = page + 1
        
        let firstPage = 0
        let lastPage = 5
        
        // 清理firstPage之前页面
        for var index = 0; index < firstPage; ++index {
            purgePage(index)
        }
        
        // 加载范围内的页面
        for index in firstPage...lastPage {
            loadPage(index)
        }
        
        // 清理lastPage之后的页面
        for var index = lastPage+1; index < pageImages.count; ++index {
            purgePage(index)
        }
    }
    
    func loadPage(page: Int) {
        if page < 0 || page >= pageImages.count {
            // 如果在显示的范围外，什么也不做
            return
        }
        
        // 加载特定页面，首先检查是否已经加载
        if let pageView = pageViews[page] {
            // 已经加载，什么也不需要做
        } else {
            var frame = scrollView.bounds
            frame.origin.x = frame.size.width * CGFloat(page)
            frame.origin.y = 0.0
            frame = CGRectInset(frame, 10.0, 0.0)
            
            let newPageView = UIImageView(image: pageImages[page])
            newPageView.contentMode = .ScaleAspectFit
            newPageView.frame = frame
            scrollView.addSubview(newPageView)
            pageViews[page] = newPageView
        }
    }
    
    func purgePage(page: Int) {
        
        if page < 0 || page >= pageImages.count {
            // 如果在显示的范围外，什么也不做
            return
        }
        
        // 从scroll view移除页面并重置容器数组
        if let pageView = pageViews[page] {
            pageView.removeFromSuperview()
            pageViews[page] = nil
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView!) {
        // 加载现在在屏幕中的页面
        println("是的")
        loadVisiblePages()
    }
    
}

