//
//  SettingsViewController.m
//  PokeGoMap
//
//  Created by Digby Andrews on 2016-07-29.
//  Copyright © 2016 Digby Andrews. All rights reserved.
//

#import "SettingsViewController.h"
#import "PokemonHelper.h"

@interface SettingsViewController () 
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SettingsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.delegate = [PokemonHelper sharedObject];
    self.tableView.dataSource = [PokemonHelper sharedObject];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
