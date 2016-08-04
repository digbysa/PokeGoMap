//
//  ViewController.m
//  PokeGoMap
//
//  Created by Digby Andrews on 2016-07-27.
//  Copyright © 2016 Digby Andrews. All rights reserved.
//

#import "PokeMapViewController.h"
#import "PokemonHelper.h"
#import "PokemonBase.h"
#import "PokemonAnnotationView.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface PokeMapViewController () <MKMapViewDelegate, CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (nonatomic) NSTimer *timer;
@property (strong, nonatomic) NSMutableArray *displayedPokemon;

@end

@implementation PokeMapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"PokeMap" image:[UIImage imageNamed:@"Image"] selectedImage:[UIImage imageNamed:@"Image"]];
    self.mapView.delegate = self;
    self.displayedPokemon = [NSMutableArray array];
    [self createLocation];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[PokemonBase class]])
    {
        PokemonAnnotationView *annotationView = [[PokemonAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"anotationIdentifier"];
        annotationView.enabled = YES;
        annotationView.canShowCallout = YES;
    
        return annotationView;
    }
    
    return nil;
}

- (void)createLocation
{
    self.locationManager = [[CLLocationManager alloc] init];
    
    if (CLLocationManager.authorizationStatus != kCLAuthorizationStatusAuthorizedWhenInUse)
    {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    if (CLLocationManager.authorizationStatus == kCLAuthorizationStatusAuthorizedWhenInUse)
    {
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    }
}
- (void)cleanPokemon
{
    
    for (PokemonBase *pokemon in self.displayedPokemon)
    {
        [self.mapView removeAnnotation:pokemon];
    }
    
    self.displayedPokemon = [NSMutableArray array];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    [self cleanPokemon];
    
    CLLocationCoordinate2D coord = [locations firstObject].coordinate;
    
    static BOOL regionIsSet = false;
    
    if (!regionIsSet)
    {
        self.mapView.centerCoordinate = coord;
        [self.mapView setRegion:MKCoordinateRegionMake(coord, MKCoordinateSpanMake(1.0, 1.0)) animated:YES];
        regionIsSet = true;
    }
    
    
    CLLocationCoordinate2D coordBegin = CLLocationCoordinate2DMake(self.mapView.centerCoordinate.latitude - 0.5 , self.mapView.centerCoordinate.longitude - 0.5);
    CLLocationCoordinate2D coordEnd = CLLocationCoordinate2DMake(self.mapView.centerCoordinate.latitude + 0.5, self.mapView.centerCoordinate.longitude + 0.5);
    
   NSString *URLToServer = [NSString stringWithFormat:@"https://skiplagged.com/api/pokemon.php?bounds=%.6f,%.6f,%.6f,%.6f",coordBegin.latitude,coordBegin.longitude,coordEnd.latitude,coordEnd.longitude];
    //NSString *URLToServer = @"https://skiplagged.com/api/pokemon.php?bounds=49.281753,-123.126088,49.288247,-123.117912";
    
    NSURL *url = [NSURL URLWithString:URLToServer];
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
                                                             options:kNilOptions
                                                               error:nil];
        NSArray *array = json[@"pokemons"];
        
        for (NSDictionary *pokemonDictionary in array)
        {
            PokemonBase *pokemon = [[PokemonBase alloc] initWithPokemonName:pokemonDictionary[@"pokemon_name"] ID:pokemonDictionary[@"pokemon_id"] andIsVisible:@1];
            pokemon.expires = pokemonDictionary[@"expires"];
            pokemon.coordinate = CLLocationCoordinate2DMake([pokemonDictionary[@"latitude"] doubleValue], [pokemonDictionary[@"longitude"] doubleValue]);
            
            [self.mapView addAnnotation:pokemon];
            __weak PokemonBase *weakPokemon = pokemon;
            
            [self.displayedPokemon addObject:weakPokemon];        }
        
    }] resume];
    
    [self.locationManager stopUpdatingLocation];
}

- (void) timerUpdate
{
    [self.locationManager startUpdatingLocation];
}

- (void)viewDidAppear:(BOOL)animated
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:15.0 target:self selector:@selector(timerUpdate) userInfo:nil repeats:YES];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [self.timer invalidate];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
