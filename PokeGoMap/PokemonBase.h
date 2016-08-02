//
//  PokemonBase.h
//  PokeGoMap
//
//  Created by Digby Andrews on 2016-07-29.
//  Copyright © 2016 Digby Andrews. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PokemonBase : NSObject <NSCoding>

@property (nonatomic, readonly) NSNumber *pokemonID;
@property (nonatomic, readonly) NSString *pokemonName;
@property (nonatomic, readonly) NSNumber *isPokemonVisible;

- (instancetype)initWithPokemonName:(NSString *)name ID:(NSNumber *)ID andIsVisible:(NSNumber *)isVisible;

@end
