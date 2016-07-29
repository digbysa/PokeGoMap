//
//  SettingsViewController.m
//  PokeGoMap
//
//  Created by Digby Andrews on 2016-07-29.
//  Copyright © 2016 Digby Andrews. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SettingsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell"];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PokemonCell"];
    }
    
    UIImageView *imageView = [cell.contentView viewWithTag:1];
    UILabel *labelView = [cell.contentView viewWithTag:2];
    UISwitch *switchView = [cell.contentView viewWithTag:3];
    
    imageView.image = [UIImage imageNamed:@"16"];
    labelView.text = [NSString stringWithFormat:@"#16 - Pidgey"];
    [switchView addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    
    return cell;
}

- (void) switchChanged:(UISwitch *) sender
{
    
}

@end
