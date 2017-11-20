//
//  RLContainerDrawerMainVC.m
//  RLObjLearn
//
//  Created by Rock Lee on 29/10/2017.
//  Copyright © 2017 Rock Lee. All rights reserved.
//

#import "RLContainerDrawerMainVC.h"
#import "RLPinAnnotation.h"
#import <MapKit/MapKit.h>

@interface RLContainerDrawerMainVC () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerTopOffsetConstraint;
@property (weak, nonatomic) IBOutlet MKMapView *mainMapView;

@property RLPinAnnotation * tmpAnnotation;


@property CGFloat originalTopOffsetValue;
@end

@implementation RLContainerDrawerMainVC

+ (void)presentContainerDrawerMainVCAsRootControllerForWindow:(UIWindow *) window{
	UIStoryboard * sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
	RLContainerDrawerMainVC * vc = [sb instantiateViewControllerWithIdentifier:@"containerDrawerMainVC"];
	
	[window setRootViewController:vc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[self setupGestures];
	[self loadMapContent];
	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - IBAction
- (IBAction)comeOutBtnClicked:(id)sender {
	_containerTopOffsetConstraint.active = YES;
	_containerTopOffsetConstraint.constant = 200;
	[UIView animateWithDuration:0.2 animations:^{
		[self.view layoutIfNeeded];
	}];
	
}
- (IBAction)showInCenterBtnClicked:(id)sender {
    
    
}

#pragma mark - Map Annotation
- (nullable MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
	MKAnnotationView * view = [mapView dequeueReusableAnnotationViewWithIdentifier:@"droppedPin"];
	RLPinAnnotation * rlAnnotation = (RLPinAnnotation *) annotation;
	if(view){
		view.annotation = rlAnnotation;
	}else{
		view = rlAnnotation.annotationView;
	}	
	view.draggable = YES;
	return view;
}

#pragma - Helper Functions
-(void)setupGestures{
	UIPanGestureRecognizer * panGestRec = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePanGesture:)];
	
	[_containerView addGestureRecognizer:panGestRec];
}

-(void)handlePanGesture:(UIPanGestureRecognizer *) panGestRec{
	//should check the difference - UITouchPhaseBegan VS. UIGestureRecognizerStateBegan
	CGPoint touchPoint = [panGestRec translationInView:_containerView];
	if(panGestRec.state == UIGestureRecognizerStateBegan){
		_originalTopOffsetValue = _containerTopOffsetConstraint.constant;
	} else if(panGestRec.state == UIGestureRecognizerStateEnded || panGestRec.state == UIGestureRecognizerStateCancelled){
		CGFloat offsetY = touchPoint.y;
		if( offsetY <=0 ||(offsetY<100&&offsetY>0)){
			NSLog(@"Drag upwards or not enough downwards (<100). Offset: %f",offsetY);
			//-100 ~ 0, resest the frame
			_containerTopOffsetConstraint.constant = _originalTopOffsetValue;
		}else if(offsetY > 100){
			_containerTopOffsetConstraint.constant = [UIScreen mainScreen].bounds.size.height;
		}
		
		[UIView animateWithDuration:0.5 animations:^{
			[self.view layoutIfNeeded];
		}];
		
	} else{
		CGFloat offsetY = touchPoint.y;
		if(offsetY <= 0){
			NSLog(@"Drag upwards. Offset: %f",offsetY);
			return;
		}
		NSLog(@"Dragging point moving around! Offset: %f",offsetY);
		_containerTopOffsetConstraint.constant = _originalTopOffsetValue + offsetY;
		[self.view layoutIfNeeded];
	}
}

- (void)mapView:(MKMapView *)mapView
 annotationView:(MKAnnotationView *)annotationView
didChangeDragState:(MKAnnotationViewDragState)newState
   fromOldState:(MKAnnotationViewDragState)oldState
{
    if (newState == MKAnnotationViewDragStateStarting)
    {
        annotationView.dragState = MKAnnotationViewDragStateDragging;
    }
    else if (newState == MKAnnotationViewDragStateEnding || newState == MKAnnotationViewDragStateCanceling)
    {
        CLLocationCoordinate2D droppedAt = annotationView.annotation.coordinate;
//        _tmpAnnotation.coordinate = droppedAt;
        NSLog(@"Pin dropped at %f,%f", droppedAt.latitude, droppedAt.longitude);
        [self.mainMapView setCenterCoordinate:droppedAt];
        
        //This has to be put at the last of this if-section
        //Otherwise, the pin will not go together with the mapView when it's dragged around
        annotationView.dragState = MKAnnotationViewDragStateNone;
    }
}


-(void)loadMapContent{
	_tmpAnnotation = [[RLPinAnnotation alloc] initWithCoordinate2D:CLLocationCoordinate2DMake(-35,144) Title:@"heck" andSubtitle:@"dick"];
	[_mainMapView addAnnotation:_tmpAnnotation];
	_mainMapView.delegate = self;
}

@end
