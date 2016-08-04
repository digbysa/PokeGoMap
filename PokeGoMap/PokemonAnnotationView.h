//
//  PokemonAnnotation.h
//  PokeGoMap
//
//  Created by Digby Andrews on 2016-08-03.
//  Copyright © 2016 Digby Andrews. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "PokemonBase.h"

@interface PokemonAnnotationView : MKAnnotationView

- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier;

@end
