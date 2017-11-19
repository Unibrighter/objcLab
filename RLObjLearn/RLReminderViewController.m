//
//  RLReminderViewController.m
//  RLObjLearn
//
//  Created by BitMad on 19/11/17.
//  Copyright © 2017 Rock Lee. All rights reserved.
//

#import "RLReminderViewController.h"

@interface RLReminderViewController ()

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)remindBtnClicked:(id)sender{
    NSLog(@"Date selected: %@", self.datePicker.date.description);
}

@end
