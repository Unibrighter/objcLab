//
//  RLHyperView.m
//  RLObjLearn
//
//  Created by Rock Lee on 21/10/2017.
//  Copyright © 2017 Rock Lee. All rights reserved.
//

#import "RLHyperView.h"

@interface RLHyperView ()

@property (readonly) CGFloat boundingBoxHeight;
@property (readonly) CGFloat boundingBoxWidth;

@end

@implementation RLHyperView

- (void)drawRect:(CGRect)rect {
	_boundingBoxWidth = rect.size.width;
	_boundingBoxHeight = rect.size.height;
	
	UIColor * targetColor = [UIColor colorWithRed:215/256.0 green:171/256.0 blue:74/256.0 alpha:1.0];
	
	//1.Inner Circle - Apple in the eye
	CGPoint centerPoint = self.center;
	CGFloat radius = _boundingBoxHeight / 10;
	
	UIBezierPath * innerPie = [[UIBezierPath alloc] init];
	
	for(;radius <= _boundingBoxWidth;radius += _boundingBoxHeight /10 ){
		[innerPie moveToPoint:CGPointMake(centerPoint.x-radius,centerPoint.y)];
		[innerPie addArcWithCenter:centerPoint radius:radius startAngle: -M_PI endAngle:M_PI clockwise:YES];
	}
	[targetColor setStroke];
	[innerPie stroke];
	
	//2. gradiant
	CGContextRef currentContext = UIGraphicsGetCurrentContext();
	currentContext = UIGraphicsGetCurrentContext();
	CGContextSaveGState(currentContext);
	UIBezierPath * gradientPath = [UIBezierPath new];
	[gradientPath moveToPoint:CGPointMake(0.5*rect.size.width , 0.333*rect.size.height)];
	[gradientPath addLineToPoint:CGPointMake(0.25*rect.size.width , 0.667*rect.size.height)];
	[gradientPath addLineToPoint:CGPointMake(0.75*rect.size.width , 0.667*rect.size.height)];
	[gradientPath addLineToPoint:CGPointMake(0.5*rect.size.width , 0.333*rect.size.height)];
	[gradientPath addClip];
	CGFloat location[2] = {0,1};
	CGFloat components [8] = {0,1,0,1,0,1,1,1};
	CGGradientRef gradient = CGGradientCreateWithColorComponents(CGColorSpaceCreateDeviceRGB(), components , location, 2);
	CGContextDrawLinearGradient(currentContext, gradient, CGPointMake(0.5*rect.size.width , 0.333*rect.size.height), CGPointMake(0.25*rect.size.width , 0.667*rect.size.height), 0);
	CGContextRestoreGState(currentContext);
	
	//3. image and shadow
	UIImage * vaultBoy = [UIImage imageNamed:@"VaultBoy"];
	CGFloat scaleRatio = 0.5*rect.size.width/vaultBoy.size.width;
	UIImage * scaledImage = [UIImage imageWithCGImage:vaultBoy.CGImage scale:1.0/scaleRatio orientation:UIImageOrientationUp];
	
	CGRect targetRect = CGRectMake(0.5*(rect.size.width - scaledImage.size.width),
								   0.5*(rect.size.height - scaledImage.size.height),
								   scaledImage.size.width, scaledImage.size.height);

	CGContextSaveGState(currentContext);
	CGContextSetShadow(currentContext, CGSizeMake(5, 5), 3);
	[scaledImage drawInRect:targetRect];
	CGContextRestoreGState(currentContext);
	

	
}



@end
