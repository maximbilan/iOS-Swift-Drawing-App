<h4>Swift Drawing Application Sample</h4>

Simple example which describes how to draw in the UIView using Swift programming language.

![alt tag](https://raw.github.com/maximbilan/ios_swift_drawing_app/master/img/img1.png)

We've two classes: DrawingLine and DrawingView. The first for storing data and the second for drawing.
DrawingLine:

<pre>
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
</pre>
