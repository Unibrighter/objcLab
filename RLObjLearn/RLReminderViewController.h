//
//  RLReminderViewController.h
//  RLObjLearn
//
//  Created by BitMad on 19/11/17.
//  Copyright © 2017 Rock Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
@import UserNotifications;

@protocol RLThemeColorDemonstrator <NSObject>

- (void)demonstrateThemeColor:(UIColor *)themeColor;

@end



@interface RLReminderViewController : UIViewController <UNUserNotificationCenterDelegate>
@property (weak, nonatomic) IBOutlet UISegmentedControl *themeColorSegmentControll;
@property id<RLThemeColorDemonstrator> delegate;
@end
