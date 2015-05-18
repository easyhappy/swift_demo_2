//
//  BezierPath.swift
//  LoadingImageView
//
//  Created by Cezar Cocu on 1/2/15.
//  Copyright (c) 2015 Cezar Cocu. All rights reserved.
//

import UIKit

extension UIBezierPath {
  
  convenience init(semiCircleInRect rect: CGRect, inset: CGFloat) {
    self.init()
    let center = CGPointMake(CGRectGetWidth(rect) / CGFloat(2.0),
      CGRectGetHeight(rect) / CGFloat(2.0))
    let minSize = min(CGRectGetWidth(rect), CGRectGetHeight(rect))
    let radius = minSize / CGFloat(2.0) - inset
    let PI2 = CGFloat(2.0 * M_PI)
    self.addArcWithCenter(center, radius: radius, startAngle: CGFloat(0.0), endAngle: PI2, clockwise: true)
  }
}// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com