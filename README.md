<h4>iOS Swift Drawing Application Sample</h4>

A simple example which describes how to draw in the <i>UIView</i> using <i>Swift</i> programming language.
We need to create the class <i>DrawingView</i> inherited from <i>UIView</i>. With the following properties:
<pre>
var drawColor = UIColor.blackColor()	// A color for drawing
var lineWidth: CGFloat = 5		// A line width
	
private var lastPoint: CGPoint!		// A point for storing the last position
private var bezierPath: UIBezierPath!	// A bezier path
private var pointCounter: Int = 0	// A counter of ponts
private let pointLimit: Int = 128	// A limit of points
private var preRenderImage: UIImage!	// A pre-render image
</pre>

First of all, initialization. We need to create <i>UIBezierPath</i> and set up some properties.

<pre>
override init(frame: CGRect) {
	super.init(frame: frame)
		
	initBezierPath()
}

required init(coder aDecoder: NSCoder) {
	super.init(coder: aDecoder)
		
	initBezierPath()
}
	
func initBezierPath() {
	bezierPath = UIBezierPath()
	bezierPath.lineCapStyle = kCGLineCapRound
	bezierPath.lineJoinStyle = kCGLineJoinRound
}
</pre>

For better performance we will store the bezier path rendering to <i>UIImage</i>, so create the function <i>renderToImage</i>.
<pre>
func renderToImage() {
		
	UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0.0)
	if preRenderImage != nil {
		preRenderImage.drawInRect(self.bounds)
	}
		
	bezierPath.lineWidth = lineWidth
	drawColor.setFill()
	drawColor.setStroke()
	bezierPath.stroke()
		
	preRenderImage = UIGraphicsGetImageFromCurrentImageContext()
		
	UIGraphicsEndImageContext()
}
</pre>

And implement the rendering function.
<pre>
override func drawRect(rect: CGRect) {
	super.drawRect(rect)
		
	if preRenderImage != nil {
		preRenderImage.drawInRect(self.bounds)
	}
		
	bezierPath.lineWidth = lineWidth
	drawColor.setFill()
	drawColor.setStroke()
	bezierPath.stroke()
}
</pre>

First, draw the pre-render image and after that render the current bezier path.<br>
Now, main of our application, it's touch handling.

In <i>touchesBegan</i> function we save the last point and reset the point counter.

<pre>
override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
	let touch: AnyObject? = touches.first
	lastPoint = touch!.locationInView(self)
	pointCounter = 0
}
</pre>

In <i>touchesMoved</i> function, add a point to the bezier path, increment the point counter and if the point counter equals a point limit, than render the bezier path to <i>UIImage</i> and reset the bezier path. And update the screen.

<pre>
override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
	let touch: AnyObject? = touches.first
	var newPoint = touch!.locationInView(self)
		
	bezierPath.moveToPoint(lastPoint)
	bezierPath.addLineToPoint(newPoint)
	lastPoint = newPoint
		
	++pointCounter
		
	if pointCounter == pointLimit {
		pointCounter = 0
		renderToImage()
		setNeedsDisplay()
		bezierPath.removeAllPoints()
	}
	else {
		setNeedsDisplay()
	}
}
</pre>

In <i>touchesEnded</i> function reset the pointer counter, render the bezier path to <i>UIImage</i>, reset the bezier path and update the screen.

<pre>
override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
	pointCounter = 0
	renderToImage()
	setNeedsDisplay()
	bezierPath.removeAllPoints()
}
</pre>

In <i>touchesCancelled</i> function just call <i>touchesEnded</i>.

<pre>
override func touchesCancelled(touches: Set<NSObject>!, withEvent event: UIEvent!) {
	touchesEnded(touches, withEvent: event)
}
</pre>

For clearing the view we need remove all points from the bezier path, reset the pre-render image and update the display:

<pre>
func clear() {
	preRenderImage = nil
	bezierPath.removeAllPoints()
	setNeedsDisplay()
}
</pre>

And for checking lines on the view:

<pre>
func hasLines() -> Bool {
	return preRenderImage != nil || !bezierPath.empty
}
</pre>

That's all and we have really simple drawing application written by <i>Swift</i>.
