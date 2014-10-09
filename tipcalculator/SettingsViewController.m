//
//  SettingsViewController.m
//  tipcalculator
//
//  Created by Rishit Shroff on 10/8/14.
//  Copyright (c) 2014 Rishit Shroff. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UITextField *option1;
@property (weak, nonatomic) IBOutlet UITextField *option2;
@property (weak, nonatomic) IBOutlet UITextField *option3;
- (IBAction)onSelect:(id)sender;

@property (weak, nonatomic) NSUserDefaults *defaults;

@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.defaults = [NSUserDefaults standardUserDefaults];

    NSString *tipPercentage1 = [self.defaults objectForKey:@"option0"];
    NSString *tipPercentage2 = [self.defaults objectForKey:@"option1"];
    NSString *tipPercentage3 = [self.defaults objectForKey:@"option2"];
    
    self.option1.text = tipPercentage1;
    self.option2.text = tipPercentage2;
    self.option3.text = tipPercentage3;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.defaults synchronize];
}

- (IBAction)onSelect:(id)sender {
    [self.view endEditing:true];
    
    if (self.option1.text.length != 0) {
        [self.defaults setObject:self.option1.text forKey:@"option0"];
    }

    if (self.option2.text.length != 0) {
        [self.defaults setObject:self.option2.text forKey:@"option1"];
    }
    if (self.option3.text.length != 0) {
        [self.defaults setObject:self.option3.text forKey:@"option2"];
    }
    [self.defaults synchronize];
}
@end
