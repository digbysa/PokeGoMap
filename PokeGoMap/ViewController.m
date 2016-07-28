//
//  ViewController.m
//  PokeGoMap
//
//  Created by Digby Andrews on 2016-07-27.
//  Copyright © 2016 Digby Andrews. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"PokeMap" image:[UIImage imageNamed:@"Image.png"] selectedImage:[UIImage imageNamed:@"Image.png"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
