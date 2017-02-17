//
//  ViewController.m
//  Method Swizzling
//
//  Created by 锦锋 on 17/2/17.
//  Copyright © 2017年 锦锋. All rights reserved.
//

#import "ViewController.h"
#import "UILabel+Swizzling.h"
@interface ViewController ()
@property(weak,nonatomic)IBOutlet UILabel *label;
@property(weak,nonatomic)IBOutlet UIButton *button;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
