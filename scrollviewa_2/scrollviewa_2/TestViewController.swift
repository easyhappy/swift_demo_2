import UIKit



class TestViewController: UIViewController ,UIScrollViewDelegate{
    
    
    
    var scroll: UIScrollView?
    
    var pageControl:UIPageControl?
    
    
    
     override func viewDidLoad() {
        
        super.viewDidLoad()
    
        
        self.title = "当前索引: 1 / 5"
        
        
        
        scroll = UIScrollView(frame: CGRectMake(0, 100, self.view.frame.size.width, 200))
        
        scroll?.backgroundColor = UIColor.redColor()
        
        scroll?.delegate = self
        
        scroll?.showsHorizontalScrollIndicator = true
        
        scroll?.showsVerticalScrollIndicator = true
        
        scroll?.pagingEnabled = true
        
        self.view.addSubview(scroll!)
        
        
        
        for var indexInt = 0; indexInt < 5; ++indexInt{
            
            
            
            var xLoca = CGFloat(indexInt) * CGFloat(self.view.frame.size.width)
            
        
            var button = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
            
            button.backgroundColor = .grayColor()
            
            button.frame = CGRectMake(xLoca, 0, self.view.frame.size.width, 200)
            
            button.setTitleColor(UIColor.whiteColor(), forState:.Normal)
            
            button.setTitle("点击按钮\(indexInt)", forState: UIControlState.Normal)
            
            button.titleLabel!.font = UIFont.boldSystemFontOfSize(CGFloat(25))
            
            button.setImage(UIImage(named:""), forState: UIControlState.Normal)
            
            button.contentMode = UIViewContentMode.ScaleAspectFit
            
            scroll!.addSubview(button)
            
            
            
        }
        
        
        
        scroll?.contentSize = CGSizeMake(5*self.view.frame.size.width, 200)
        
        scroll?.setContentOffset(CGPointMake(0, 0), animated: true)
        
        
        
        pageControl = UIPageControl(frame: CGRectMake(0, 320, self.view.frame.size.width,40))
        
        pageControl?.backgroundColor = UIColor.clearColor()
        
        pageControl?.numberOfPages = 5
        
        pageControl?.currentPage = 0
        
        pageControl?.pageIndicatorTintColor = UIColor.blackColor()
        
        pageControl?.currentPageIndicatorTintColor = UIColor.redColor()
        
        pageControl?.userInteractionEnabled = false
        
        self.view.addSubview(pageControl!)
        
        
        
    }
    
    
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        var index = Int(scrollView.contentOffset.x/scrollView.frame.size.width)
        
        pageControl?.currentPage = index
        
        self.title = "当前索引: \(index+1) / 5"
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
        
    }
    
    
    
}

 