//
//  PokemonHelper.h
//  PokeGoMap
//
//  Created by Digby Andrews on 2016-08-02.
//  Copyright © 2016 Digby Andrews. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PokemonHelper : NSObject

+ (instancetype)sharedObject;
- (void)setIsVisible:(NSNumber *)isVisible forPokemonNumber:(NSNumber *)pokemonNumber;

@end
