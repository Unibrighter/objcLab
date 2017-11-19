//
//  AppDelegate.m
//  RLObjLearn
//
//  Created by Rock Lee on 21/10/2017.
//  Copyright © 2017 Rock Lee. All rights reserved.
//

#import "AppDelegate.h"
#import "RLHyperView.h"
#import "RLContainerDrawerMainVC.h"
#import "RLHyperViewController.h"
#import "RLReminderViewController.h"

@import MapKit;
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//	[self slideView];
//	[self freeCameraView];
    [self tabViewController];
	
	return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
	// Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - UIViewController Ex
-(void)tabViewController{
    
    RLHyperViewController * hyperVC = [[RLHyperViewController alloc]init];
    
    RLReminderViewController * reminderVC = [[RLReminderViewController alloc] initWithNibName:@"RLReminderViewController" bundle:[NSBundle mainBundle]];
    
    UITabBarController * tabViewController = [[UITabBarController alloc] init];
    tabViewController.viewControllers = @[hyperVC,reminderVC];

    [self.window setRootViewController:tabViewController];
}




#pragma mark - UIScrollView Exercise
- (void) slideView{
	
	RLHyperView * hyperView1 = [[RLHyperView alloc]init];
	RLHyperView * hyperView2 = [[RLHyperView alloc] init];
	
	
	CGRect cameraFrame = [UIScreen  mainScreen].bounds;
	CGRect canvasFrame = [UIScreen mainScreen].bounds;
	canvasFrame.size.width *=2;
//	canvasFrame.size.width *=2;
	
	
	hyperView1.frame = cameraFrame;
	cameraFrame.origin.x = [UIScreen mainScreen].bounds.size.width;
	hyperView2.frame = cameraFrame;
	
	UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen  mainScreen].bounds];
	scrollView.contentSize = canvasFrame.size;
	[scrollView addSubview:hyperView1];
	[scrollView addSubview:hyperView2];
	
	[scrollView setPagingEnabled:YES];
	
	UIViewController * rootVC = [UIViewController new];
	[rootVC.view addSubview:scrollView];
//	hyperView1.userInteractionEnabled =NO;
//	hyperView2.userInteractionEnabled = NO;
	scrollView.scrollEnabled = YES;
	[self.window setRootViewController:rootVC];
	[self.window makeKeyAndVisible];

}

- (void) freeCameraView{
	RLHyperView * hyperView1 = [[RLHyperView alloc]init];
	CGRect cameraFrame = [UIScreen  mainScreen].bounds;
	CGRect canvasFrame = [UIScreen mainScreen].bounds;
	canvasFrame.size.width *=2;
	canvasFrame.size.height *=2;
	
	
	UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:cameraFrame];
	hyperView1.frame = canvasFrame;	
	scrollView.contentSize = canvasFrame.size;
	[scrollView addSubview:hyperView1];
	
	UIViewController * rootVC = [UIViewController new];
	[rootVC.view addSubview:scrollView];
	[self.window setRootViewController:rootVC];
	[self.window makeKeyAndVisible];

}

#pragma mark - Single View Ex
- (void) singleHyperViewTest{
	//	self.window.rootViewController = [UIViewController new];
	
	RLHyperView * hyperView = [[RLHyperView alloc] initWithFrame:self.window.frame];
	hyperView.backgroundColor = [UIColor whiteColor];
	
	self.window.rootViewController=[UIViewController new];
	//	self.window.rootViewController.view = hyperView;
	
	[self.window addSubview:hyperView];
	
	[self.window makeKeyAndVisible];
	
	
	//	UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (self.window.bounds.size.width)/2, (self.window.bounds.size.height)/2)];
	//	imageView.contentMode = UIViewContentModeScaleAspectFit;
	//	imageView.image = vaultBoy;
	//	imageView.center = self.window.center;
	//	[self.window addSubview:imageView];
	
	
	self.window.subviews[1].userInteractionEnabled = NO;
	
	
	//	[RLContainerDrawerMainVC presentContainerDrawerMainVCAsRootControllerForWindow:self.window];
}


@end
