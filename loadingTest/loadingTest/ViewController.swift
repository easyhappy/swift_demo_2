//
//  ViewController.swift
//  loadingTest
//
//  Created by andyhu on 15/2/11.
//  Copyright (c) 2015年 andyhu. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {
    var aiv:UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        showLoading()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func showLoading(){
        let circle = UIView();
        
        circle.bounds = CGRect(x: 0,y: 0, width: 100, height: 100);
        circle.frame = CGRectMake(0,0, 100, 100);
        
        circle.layoutIfNeeded()
        
        var progressCircle = CAShapeLayer();
        
        let centerPoint = CGPoint (x: circle.bounds.width / 2, y: circle.bounds.width / 2);
        let circleRadius : CGFloat = circle.bounds.width / 2 * 0.83;
        
        var circlePath = UIBezierPath(arcCenter: centerPoint, radius: circleRadius, startAngle: CGFloat(-0.5 * M_PI), endAngle: CGFloat(1.5 * M_PI), clockwise: true    );
        
        progressCircle = CAShapeLayer ();
        progressCircle.path = circlePath.CGPath;
        progressCircle.strokeColor = UIColor.greenColor().CGColor;
        progressCircle.fillColor = UIColor.clearColor().CGColor;
        progressCircle.lineWidth = 1.5;
        progressCircle.strokeStart = 0;
        progressCircle.strokeEnd = 0.22;
        
        circle.layer.addSublayer(progressCircle);
        aiv = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        aiv.frame = CGRectMake(200,300, 10, 10);
        self.view.addSubview(aiv)
        aiv.startAnimating()
        self.view.addSubview(circle)
    }
    
    
    @IBAction func clickButton(){
        if self.aiv.isAnimating(){
            self.aiv.stopAnimating()
        }else{
            self.aiv.startAnimating()
            
        }
    }

}

