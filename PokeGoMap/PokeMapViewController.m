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

@end

@implementation PokeMapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"PokeMap" image:[UIImage imageNamed:@"Image"] selectedImage:[UIImage imageNamed:@"Image"]];
    self.mapView.delegate = self;
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

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocationCoordinate2D coord = [locations firstObject].coordinate;
    [self.mapView setRegion:MKCoordinateRegionMake(coord, MKCoordinateSpanMake(0.025, 0.025)) animated:YES];
    
    CLLocationCoordinate2D coordBegin = CLLocationCoordinate2DMake(coord.latitude - 1, coord.longitude - 1);
    CLLocationCoordinate2D coordEnd = CLLocationCoordinate2DMake(coord.latitude + 1, coord.longitude + 1);
    
    PokemonBase *pokemon = [[PokemonBase alloc] initWithPokemonName:@"Pyro" ID:@47 andIsVisible:@1];
    pokemon.coordinate = self.mapView.userLocation.coordinate;
    [self.mapView addAnnotation:pokemon];
    
    
   /* NSString *URLToServer = [NSString stringWithFormat:@"https://skiplagged.com/api/pokemon.php?bounds=%.6f,%.6f,%.6f,%.6f",coordBegin.latitude,coordBegin.longitude,coordEnd.latitude,coordEnd.longitude];
    NSString *URLToServer = @"https://skiplagged.com/api/pokemon.php?bounds=49.281753,-123.126088,49.288247,-123.117912";
    
    NSURL *url = [NSURL URLWithString:URLToServer];
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
                                                             options:kNilOptions
                                                               error:nil];
        NSLog(@"%@", json);
    }] resume];*/
    
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
