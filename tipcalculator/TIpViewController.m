//
//  TipViewController.m
//  tipcalculator
//
//  Created by Rishit Shroff on 10/8/14.
//  Copyright (c) 2014 Rishit Shroff. All rights reserved.
//

#import "TipViewController.h"
#import "SettingsViewController.h"

@interface TipViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tipBillField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipTotalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipValueSelector;
@property (weak, nonatomic) NSUserDefaults *defaults;

@property (atomic) NSArray *tipValues;

- (IBAction)onTap:(id)sender;

- (void)updateValues;
- (void)onSettingsButton;
- (void)populateTipOptions;

@end

@implementation TipViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Tip Calculator";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tipBillField.text = @"";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];
    [self populateTipOptions];
   }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:true];
    [self updateValues];
}

- (void)updateValues {
    float billAmount = [self.tipBillField.text floatValue];
    float tipAmount = [self.tipValues[self.tipValueSelector.selectedSegmentIndex] floatValue] * billAmount;
    float totalAmount = billAmount + tipAmount;
    self.tipLabel.text = [NSString stringWithFormat:@"$%0.2f", tipAmount];
    self.tipTotalLabel.text = [NSString stringWithFormat:@"$%0.2f", totalAmount];
}

- (void)onSettingsButton {
    [self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [self populateTipOptions];
}

- (void)populateTipOptions {
    self.defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *tipPercentage1 = [self.defaults objectForKey:@"option0"];
    NSString *tipPercentage2 = [self.defaults objectForKey:@"option1"];
    NSString *tipPercentage3 = [self.defaults objectForKey:@"option2"];

    BOOL notPresent = false;
    if (tipPercentage1 == nil) {
        tipPercentage1 = @"10";
        [self.defaults setObject:@"10" forKey:@"option0"];
        notPresent = true;
    }
    
    if (tipPercentage2 == nil) {
        tipPercentage2 = @"15";
        [self.defaults setObject:@"15" forKey:@"option1"];
        notPresent = true;
    }
    
    if (tipPercentage3 == nil) {
        tipPercentage3 = @"20";
        [self.defaults setObject:@"20" forKey:@"option2"];
        notPresent = true;
    }
    
    if (notPresent) {
        [self.defaults synchronize];
    }
    
    [self.tipValueSelector setTitle:tipPercentage1 forSegmentAtIndex:0];
    [self.tipValueSelector setTitle:tipPercentage2 forSegmentAtIndex:1];
    [self.tipValueSelector setTitle:tipPercentage3 forSegmentAtIndex:2];
    
    self.tipValues = @[@([tipPercentage1 floatValue]/100),
                       @([tipPercentage2 floatValue]/100),
                       @([tipPercentage3 floatValue]/100)];
}

@end
