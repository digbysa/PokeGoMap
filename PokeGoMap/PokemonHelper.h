//
//  PokemonHelper.h
//  PokeGoMap
//
//  Created by Digby Andrews on 2016-08-02.
//  Copyright © 2016 Digby Andrews. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PokemonHelper : NSObject <UITableViewDataSource, UITableViewDelegate>

+ (instancetype)sharedObject;
- (void)saveChanges;
@end
