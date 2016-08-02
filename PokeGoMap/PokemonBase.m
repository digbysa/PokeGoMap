//
//  PokemonBase.m
//  PokeGoMap
//
//  Created by Digby Andrews on 2016-07-29.
//  Copyright © 2016 Digby Andrews. All rights reserved.
//

#import "PokemonBase.h"

@implementation PokemonBase

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.pokemonID forKey:@"pokemonID"];
    [coder encodeObject:self.pokemonName forKey:@"pokemonName"];
    [coder encodeObject:self.isPokemonVisible forKey:@"isPokemonVisible"];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    NSNumber *pokemonID = [coder decodeObjectForKey:@"pokemonID"];
    NSString *pokemonName = [coder decodeObjectForKey:@"pokemonName"];
    NSNumber *isPokemonVisible = [coder decodeObjectForKey:@"isPokemonVisible"];
    
    self = [self initWithPokemonName:pokemonName ID:pokemonID andIsVisible:isPokemonVisible];
    return self;
}

- (instancetype)initWithPokemonName:(NSString *)name ID:(NSNumber *)ID andIsVisible:(NSNumber *)isVisible
{
    self = [super init];
    if (self)
    {
        _pokemonID = ID;
        _pokemonName = name;
        _isPokemonVisible = isVisible;
    }
    return self;
}

@end
