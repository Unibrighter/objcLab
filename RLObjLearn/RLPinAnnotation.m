//
//  RLPinAnnotation.m
//  RLObjLearn
//
//  Created by Rock Lee on 30/10/2017.
//  Copyright © 2017 Rock Lee. All rights reserved.
//

#import "RLPinAnnotation.h"
#import <MapKit/MapKit.h>

@interface RLPinAnnotation() 

@end

@implementation RLPinAnnotation

-(instancetype)initWithCoordinate2D:(CLLocationCoordinate2D) co Title:(NSString *)title andSubtitle:(NSString *) subtitle{
	self = [super init];
	if(nil !=self){
		_coordinate = co;
		_title = title;
		_subtitle = subtitle;
	}
	return self;
}


- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate{
	_coordinate = newCoordinate;
}

-(MKAnnotationView *_Nullable)annotationView{
	MKAnnotationView * view = [[MKAnnotationView alloc] initWithAnnotation:self reuseIdentifier:@"droppedPin"];
	
	view.enabled = YES;
//	view.canShowCallout = YES;
	UIImage *pinImage = [UIImage imageNamed:@"map-marker-icon"];
	view.image = [UIImage imageWithCGImage:pinImage.CGImage scale:pinImage.size.height/10.0 orientation:UIImageOrientationUp];
	view.draggable = YES;
	
	view.centerOffset = CGPointMake(0, -view.frame.size.height / 2);
	return view;
}

@end
