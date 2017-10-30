//
//  RLPinAnnotation.h
//  RLObjLearn
//
//  Created by Rock Lee on 30/10/2017.
//  Copyright © 2017 Rock Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface RLPinAnnotation : NSObject <MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly, copy, nullable) NSString *title;
@property (nonatomic, readonly, copy, nullable) NSString *subtitle;


-(instancetype)initWithCoordinate2D:(CLLocationCoordinate2D) co Title:(NSString *)title andSubtitle:(NSString *) subtitle;
-(MKAnnotationView *_Nullable)annotationView;

@end
