//
//  FormViewController.m
//  SCTestClient
//
//  Created by Joan Romano on 3/15/15.
//  Copyright (c) 2015 SoundCloud. All rights reserved.
//

#import "FormViewController.h"

#import <RACStream.h>
#import <RACSignal.h>
#import <RACTuple.h>
#import <RACCommand.h>
#import <RACSubscriptingAssignmentTrampoline.h>
#import <NSObject+RACLifting.h>
#import <NSObject+RACPropertySubscribing.h>
#import <RACSignal+Operations.h>
#import <UIControl+RACSignalSupport.h>
#import <UIButton+RACCommandSupport.h>
#import <UITextField+RACSignalSupport.h>

#import "FormViewModel.h"
#import "ResultsViewController.h"

@interface FormViewController ()

@property (nonatomic, weak) IBOutlet UITextField *usernameTextField;
@property (nonatomic, weak) IBOutlet UIButton *goButton;

@property (nonatomic, strong) FormViewModel *viewModel;

@end

@implementation FormViewController

- (instancetype)init
{
    if (self = [super init])
    {
        _viewModel = [[FormViewModel alloc] init];
        
        self.title = @"Enter Username";
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupBindingsAndSubviews];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.usernameTextField becomeFirstResponder];
}

#pragma mark - Private

- (void)setupBindingsAndSubviews
{
    RAC(self.viewModel, formInput) = [self.usernameTextField rac_textSignal];
    RAC(self.goButton, rac_command) = RACObserve(self, viewModel.formCommand);
    
    [self.view rac_liftSelector:@selector(endEditing:) withSignalOfArguments:
     [[RACSignal merge:
       @[self.goButton.rac_command.executing,
         [self.usernameTextField rac_signalForControlEvents:UIControlEventEditingDidEndOnExit]]]
      mapReplace:RACTuplePack(@YES)]];
    
    [self.navigationController rac_liftSelector:@selector(pushViewController:animated:)
                           withSignalsFromArray:
  @[[[self.goButton.rac_command.executionSignals flatten] map:^id(id viewModel) {
        return [[ResultsViewController alloc] initWithViewModel:viewModel];
    }], [RACSignal return:@YES]]];
}

@end
