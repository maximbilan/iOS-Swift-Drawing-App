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
	
	init(start _start: CGPoint, end _end: CGPoint, color _color: UIColor!) {
		start = _start
		end = _end
		color = _color
	}
}

class DrawingView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
