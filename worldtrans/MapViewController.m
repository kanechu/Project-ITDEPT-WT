//
//  MapViewController.m
//  worldtrans
//
//  Created by itdept on 14-4-3.
//  Copyright (c) 2014年 itdept. All rights reserved.
//

#import "MapViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "MapAnnotation.h"
@interface MapViewController ()

@end

@implementation MapViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    _mapView.delegate=self;
    _mapView.mapType=MKMapTypeStandard;
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    NSLog(@"%@",_adress_name);
    [geocoder geocodeAddressString:@"xianggang" completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if ([placemarks count] > 0) {
            [_mapView removeAnnotations:_mapView.annotations];
        }
        
        for (int i = 0; i < [placemarks count]; i++) {
            
            CLPlacemark* placemark = placemarks[i];
            
            //调整地图位置和缩放比例
            MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(placemark.location.coordinate, 10000, 10000);
            [_mapView setRegion:viewRegion animated:YES];
            
            MapAnnotation *annotation = [[MapAnnotation alloc] init];
            annotation.streetAddress = placemark.thoroughfare;
            annotation.city = placemark.locality;
            annotation.state = placemark.administrativeArea;
            annotation.zip = placemark.postalCode;
            annotation.coordinate = placemark.location.coordinate;
            
            [_mapView addAnnotation:annotation];
        }
    }];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark Map View Delegate Methods
- (MKAnnotationView *) mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>) annotation {
	
	MKPinAnnotationView *annotationView
	= (MKPinAnnotationView *)[_mapView dequeueReusableAnnotationViewWithIdentifier:@"PIN_ANNOTATION"];
	if(annotationView == nil) {
		annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                                         reuseIdentifier:@"PIN_ANNOTATION"];
	}
    
	annotationView.pinColor = MKPinAnnotationColorPurple;
	annotationView.animatesDrop = YES;
	annotationView.canShowCallout = YES;
	
	return annotationView;
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
   // _mapView.centerCoordinate = userLocation.location.coordinate;
}

- (void)mapViewDidFailLoadingMap:(MKMapView *)theMapView withError:(NSError *)error {
    NSLog(@"error : %@",[error description]);
}



@end
