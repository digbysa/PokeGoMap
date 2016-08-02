//
//  ViewController.m
//  PokeGoMap
//
//  Created by Digby Andrews on 2016-07-27.
//  Copyright © 2016 Digby Andrews. All rights reserved.
//

#import "PokeMapViewController.h"
#import "PokemonHelper.h"

@interface PokeMapViewController ()

@end

@implementation PokeMapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"PokeMap" image:[UIImage imageNamed:@"Image"] selectedImage:[UIImage imageNamed:@"Image"]];
    
    [PokemonHelper sharedObject];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
