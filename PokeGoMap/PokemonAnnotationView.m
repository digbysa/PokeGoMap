//
//  PokemonAnnotation.m
//  PokeGoMap
//
//  Created by Digby Andrews on 2016-08-03.
//  Copyright © 2016 Digby Andrews. All rights reserved.
//

#import "PokemonAnnotationView.h"

@implementation PokemonAnnotationView

- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self)
    {
        CGRect  myFrame = self.frame;
        myFrame.size.width = 50;
        myFrame.size.height = 50;
        self.image = [UIImage imageNamed:[((PokemonBase*)annotation).pokemonID stringValue]];
        self.frame = myFrame;
        self.opaque = NO;
        self.centerOffset = CGPointMake(24, 24);
    }
    
    return self;
}

@end
