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

- (IBAction)switchAllChanged:(UISwitch *)sender
{
    for (UITableViewCell *cell in self.tableView.visibleCells)
    {
        UISwitch *switchBtn = [cell viewWithTag:3];
        [switchBtn setOn:[sender isOn]];
        NSNumber *number = [NSNumber numberWithInteger:[self.tableView indexPathForCell:cell].row + 1];
        [[PokemonHelper sharedObject] switchVisibilityTo:[sender isOn] ForPokemonNumber:number];
    }
}

- (IBAction)sort:(UIButton *)sender
{
    char value = [sender.titleLabel.text characterAtIndex:0];
    switch (value) {
        case 'A':
            [[PokemonHelper sharedObject] setSortMode:PSM_ALPHA forTableView:self.tableView];
            break;
            
        default:
            [[PokemonHelper sharedObject] setSortMode:PSM_NUMBER forTableView:self.tableView];
            break;
    }
}


@end
