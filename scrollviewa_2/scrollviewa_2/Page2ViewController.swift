//
//  ViewController.swift
//  scrollView
//
//  Created by andyhu on 15/1/12.
//  Copyright (c) 2015年 andyhu. All rights reserved.
//

import UIKit

class Page2ViewController: UIViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate{
    
    @IBOutlet weak var b: NSLayoutConstraint!
    @IBOutlet weak var a: NSLayoutConstraint!
    @IBOutlet var doubleTap: UITapGestureRecognizer!
    
    @IBOutlet weak var scrollHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollTop: NSLayoutConstraint!
    @IBOutlet var singleTap: UITapGestureRecognizer!
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var pageControl: UIPageControl!
    
    @IBOutlet var viewDouble: UITapGestureRecognizer!
    
    var pageImages: [UIImage] = []
    var pageViews: [UIImageView?] = []
    var last_page = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doubleTap.numberOfTapsRequired = 2
        singleTap.numberOfTapsRequired = 1
        self.singleTap.requireGestureRecognizerToFail(self.doubleTap)
        // 1
        pageImages.append(UIImage(named: "photo1.png")!)
        pageImages.append(UIImage(named: "photo2.png")!)
        pageImages.append(UIImage(named: "photo3.png")!)
        pageImages.append(UIImage(named: "photo4.png")!)
        pageImages.append(UIImage(named: "photo5.png")!)
        pageImages.append(UIImage(named: "photo5.png")!)
        
        
        let pageCount = pageImages.count
        
        // 2
        pageControl.currentPage = 0
        pageControl.numberOfPages = 2
        
        // 3
        for _ in 0..<pageCount {
            pageViews.append(nil)
        }
        
        let pagesScrollViewSize = scrollView.frame.size
        scrollView.contentSize = CGSize(width: pagesScrollViewSize.width * CGFloat(pageImages.count),
            height: pagesScrollViewSize.height)
        
        // 5
        scrollView.contentSize = CGSizeMake(5*self.view.frame.size.width, 200)
        
        //scrollView.setContentOffset(CGPointMake(0, 0), animated: true)
        loadVisiblePages()
        scrollView.showsHorizontalScrollIndicator = false
        //
        scrollView.showsVerticalScrollIndicator = false
        
        
        //        scrollView.contentSize = CGSizeMake(5*self.view.frame.size.width, 200)
        //
        //        scrollView.setContentOffset(CGPointMake(0, 0), animated: true)
        
    }
    
    func loadPage(page: Int) {
        if page < 0 || page >= pageImages.count {
            // 如果超出了页面显示的范围，什么也不需要做
            return
        }
        
        for i in (page*3)...((page+1)*3-1){
            loadChildPage(i)
        }
        
    }
    
    @IBAction func doubleTapDeal(){
        println(" good is yes ")
    }

    
    func loadChildPage(page: Int){
        if page >= pageViews.count{
            return
        }
        if let pageView = pageViews[page] {
            // 页面已经加载，不需要额外操作
        } else {
            // 2
            var frame = scrollView.bounds
            frame.origin.x = frame.size.width * CGFloat(page)
            frame.origin.y = 0.0
            
            // 3
            let newPageView = UIImageView(image: pageImages[page])
            var doubleTapRecognizer = UITapGestureRecognizer(target: self, action: "scrollViewDoubleTapped:")
            doubleTapRecognizer.numberOfTapsRequired = 2
            doubleTapRecognizer.numberOfTouchesRequired = 1
            scrollView.addGestureRecognizer(doubleTapRecognizer)
            
            
            newPageView.contentMode = .ScaleAspectFit
            var xLoca = CGFloat(page) * CGFloat(self.view.frame.size.width)/3
            newPageView.frame =  CGRectMake(xLoca, 0, self.view.frame.size.width/3, 200)
            scrollView.addSubview(newPageView)
            
            // 4
            pageViews[page] = newPageView
        }
    }
    
    
    
    func scrollViewDoubleTapped(recognizer: UITapGestureRecognizer) {
        var a = self.view.frame.size.width/3
        var x = recognizer.locationInView(self.scrollView).x
        var c = Int(x*1.0/a)

        println("double click: \(x)  is the \(c) Int c is \(Int(c))")
        
        
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
        var page = Int(floor((scrollView.contentOffset.x * 2.0 + pageWidth) / (pageWidth * 2.0)))
        //page = Int(scrollView.contentOffset.x/pageWidth)
       
        if page > last_page{
            last_page += 1
        }
        if page < last_page{
            last_page -= 1
        }
        if last_page < 0{
            last_page = 0
        }
        if last_page > self.pageImages.count{
            last_page = self.pageImages.count
        }
        //page = last_page
        
        
        // 更新pageControl
        pageControl.currentPage = last_page
        
        // 计算那些页面需要加载
        var firstPage = last_page - 1
        var lastPage = last_page + 1
        
        // 清理firstPage之前的所有页面
        for var index = 0; index < firstPage; ++index {
            //purgePage(index)
        }
        
        // 加载范围内（firstPage到lastPage之间）的所有页面
        for index in firstPage...lastPage {
            loadPage(index)
        }
        
        // 清理lastPage之后的所有页面
        for var index = lastPage+1; index < pageImages.count; ++index {
            //purgePage(index)
        }
        
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView!) {
        // Load the pages that are now on screen
        loadVisiblePages()
//        sleep(3)
    
        self.scrollView.hidden = true
        //self.scrollView.removeFromSuperview()
        self.scrollView.frame.size.height = 0
       
        scrollHeight.constant = 0
        scrollTop.constant = 0
        println("a.contant \(a.constant)")
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

