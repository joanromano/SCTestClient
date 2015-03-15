//
//  FormViewController.m
//  SCTestClient
//
//  Created by Joan Romano on 3/15/15.
//  Copyright (c) 2015 SoundCloud. All rights reserved.
//

#import "FormViewController.h"

@interface FormViewController ()

@property (nonatomic, weak) IBOutlet UITextField *usernameTextField;

@end

@implementation FormViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(IBAction)editingEnded:(id)sender
{
    [sender resignFirstResponder];
}

-(IBAction)buttonPressed:(id)sender
{
    [self editingEnded:self.usernameTextField];
}

@end
