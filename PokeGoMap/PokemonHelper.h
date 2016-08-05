//
//  PokemonHelper.h
//  PokeGoMap
//
//  Created by Digby Andrews on 2016-08-02.
//  Copyright © 2016 Digby Andrews. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PokemonSortMode)
{
    PSM_NUMBER = 0,
    PSM_ALPHA = 1
};

@interface PokemonHelper : NSObject <UITableViewDataSource, UITableViewDelegate>

+ (instancetype)sharedObject;
- (void)saveChanges;
- (void)switchVisibilityTo:(BOOL)visibility ForPokemonNumber:(NSNumber *)pokemonNumber;
- (BOOL)getPokemonIsVisible:(NSNumber *)pokemonNumber;
- (void)setSortMode:(PokemonSortMode)mode forTableView:(UITableView *)tableView;

@end
