//
//  DrawingView.swift
//  ios_swift_drawing_app
//
//  Created by Maxim Bilan on 4/29/15.
//  Copyright (c) 2015 Maxim Bilan. All rights reserved.
//

import UIKit

class DrawingLine {
	var start: CGPoint
	var end: CGPoint
	var color: UIColor
	var width: CGFloat
	
	init(start _start: CGPoint, end _end: CGPoint, color _color: UIColor!, width _width: CGFloat) {
		start = _start
		end = _end
		color = _color
		width = _width
	}
}

class DrawingView: UIView {
	
	var lines: [DrawingLine] = []
	var lastPoint: CGPoint!
	var drawColor = UIColor.blackColor()
	var lineWidth: CGFloat = 5
	
	override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
		let touch: AnyObject? = touches.first
		lastPoint = touch!.locationInView(self)
	}
	
	override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
		let touch: AnyObject? = touches.first
		
		var newPoint = touch!.locationInView(self)
		lines.append(DrawingLine(start: lastPoint, end: newPoint, color: drawColor, width: lineWidth))
		lastPoint = newPoint
		
		setNeedsDisplay()
	}
	
	override func drawRect(rect: CGRect) {
		var context = UIGraphicsGetCurrentContext()
		CGContextBeginPath(context)
		for line in lines {
			CGContextSetLineWidth(context, line.width)
			CGContextSetLineCap(context, kCGLineCapRound)
			CGContextMoveToPoint(context, line.start.x, line.start.y)
			CGContextAddLineToPoint(context, line.end.x, line.end.y)
			CGContextSetStrokeColorWithColor(context, line.color.CGColor)
			CGContextStrokePath(context)
		}
	}
	
}
