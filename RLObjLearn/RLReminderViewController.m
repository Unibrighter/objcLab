//
//  RLReminderViewController.m
//  RLObjLearn
//
//  Created by BitMad on 19/11/17.
//  Copyright © 2017 Rock Lee. All rights reserved.
//

#import "RLReminderViewController.h"
#import <UserNotifications/UserNotifications.h>



@interface RLReminderViewController ()<UNUserNotificationCenterDelegate>

@property (weak,nonatomic) IBOutlet UIDatePicker* datePicker;


@end

@implementation RLReminderViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(nil!=self){
        self.tabBarItem.title = @"Reminder View";
        self.tabBarItem.image = [UIImage imageNamed:@"timer"];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated{
    self.datePicker.minimumDate = [NSDate dateWithTimeIntervalSinceNow:60];
    self.themeColorSegmentControll.selectedSegmentIndex = UISegmentedControlNoSegment;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)remindBtnClicked:(id)sender{
    NSLog(@"Date selected: %@", self.datePicker.date);
    
//    NSString * content = [NSString stringWithFormat:@"You have appointed a hyper session at %@",self.datePicker.date];
//    UNNotificationRequest * notification = [UNNotificationRequest requestWithIdentifier:@"Time to hyper" content:content trigger:nil];
//    
//    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:notification withCompletionHandler:nil];
//    
//    
//    
    
    UNMutableNotificationContent* content = [[UNMutableNotificationContent alloc] init];
    content.title = [NSString localizedUserNotificationStringForKey:@"Hyper Session!" arguments:nil];
    content.body = [NSString localizedUserNotificationStringForKey:@"Hello_message_body"
                                                         arguments:nil];
    content.sound = [UNNotificationSound defaultSound];
    
    // Deliver the notification in five seconds.
    UNTimeIntervalNotificationTrigger* trigger = [UNTimeIntervalNotificationTrigger
                                                triggerWithTimeInterval:[self.datePicker.date timeIntervalSinceNow] repeats:NO];
    
    UNNotificationRequest* request = [UNNotificationRequest requestWithIdentifier:@"FiveSecond"
                                                                          content:content trigger:trigger];
    
    // Schedule the notification.
    UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
    [center addNotificationRequest:request withCompletionHandler:nil];
    
}


- (IBAction)onValueChanged:(id)sender {
    UIColor *themeColor;
    switch (self.themeColorSegmentControll.selectedSegmentIndex) {
        case 0:
            themeColor = [UIColor redColor];
            break;
        case 1:
            themeColor = [UIColor yellowColor];
            break;
        case 2:
            themeColor = [UIColor blueColor];
            break;
        default:
            break;
    }
    if (self.delegate){
        [self.delegate demonstrateThemeColor:themeColor];
    }
    self.themeColorSegmentControll.selectedSegmentIndex = UISegmentedControlNoSegment;
}

@end
