//
//  PokemonBase.h
//  PokeGoMap
//
//  Created by Digby Andrews on 2016-07-29.
//  Copyright © 2016 Digby Andrews. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface PokemonBase : NSObject <NSCoding, MKAnnotation>

@property (nonatomic, readonly) NSNumber *pokemonID;
@property (nonatomic, readonly) NSString *pokemonName;
@property (nonatomic) NSNumber *isPokemonVisible;
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic) NSNumber *expires;

- (instancetype)initWithPokemonName:(NSString *)name ID:(NSNumber *)ID andIsVisible:(NSNumber *)isVisible;

@end
