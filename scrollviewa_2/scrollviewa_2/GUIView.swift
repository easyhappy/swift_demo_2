//
//  GUIView.swift
//  scrollviewa_2
//
//  Created by andyhu on 15/1/14.
//  Copyright (c) 2015年 andyhu. All rights reserved.
//

import UIKit

class GUIView: UIImageView, UIGestureRecognizerDelegate {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    func yes(){
        var doubleTapRecognizer = UITapGestureRecognizer(target: self, action: "scrollViewDoubleTapped")
        doubleTapRecognizer.numberOfTapsRequired = 2
        doubleTapRecognizer.numberOfTouchesRequired = 1
        self.addGestureRecognizer(doubleTapRecognizer)
    }
    
    
    func scrollViewDoubleTapped(recognizer: UITapGestureRecognizer) {
        println("double 111 click: \(recognizer.view)")
    }

}
