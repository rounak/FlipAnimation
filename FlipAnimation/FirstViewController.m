//
//  FirstViewController.m
//  FlipAnimation
//
//  Created by Rounak Jain on 06/04/14.
//  Copyright (c) 2014 Rounak Jain. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

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
    self.title = @"First";
    self.tapView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 160, 284)];
    [self.tapView setImage:[UIImage imageNamed:@"ffffff"] forState:UIControlStateNormal];
    self.tapView.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    [self.tapView addTarget:self action:@selector(pushSecondViewController) forControlEvents:UIControlEventTouchUpInside];
    self.tapView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.tapView];
    // Do any additional setup after loading the view.
}

- (void)pushSecondViewController
{
    SecondViewController *secondViewController = [[SecondViewController alloc] init];
    [self.navigationController pushViewController:secondViewController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
