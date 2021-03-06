/*
 * Copyright (C) 2010- Peer internet solutions
 *
 * This file is part of mixare.
 *
 * This program is free software: you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU General Public License
 * for more details.
 *
 * You should have received a copy of the GNU General Public License along with
 * this program. If not, see <http://www.gnu.org/licenses/>
 */

#import "MapViewController.h"
#import "WebViewController.h"

@implementation MapViewController
@synthesize map  = _map;

- (void)viewDidLoad {
	[super viewDidLoad];
    _map.delegate = self;
	MKCoordinateRegion newRegion;
	CLLocationManager* locmng = [[CLLocationManager alloc]init];
	newRegion.center.latitude = locmng.location.coordinate.latitude;
	newRegion.center.longitude = locmng.location.coordinate.longitude;
	newRegion.span.latitudeDelta = 0.03;
	newRegion.span.longitudeDelta = 0.03;
	[self.map setRegion:newRegion animated:YES];
    if (_currentAnnotations == nil) {
        _currentAnnotations = [[NSMutableArray alloc] init];
    }
    popUpView = [[PopUpWebView alloc] initWithMainView:self.view padding:0 isTabbar:YES rightRotateable:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

- (void)refresh:(NSMutableArray*)dataSources {
    [self removeAllAnnotations];
    for (DataSource *data in dataSources) {
        [self addAnnotationsFromDataSource:data];
    }
}

- (void)addAnnotationsFromDataSource:(DataSource *)data{
	if(data.positions != nil){
		for(Position *pos in data.positions) {
            [_currentAnnotations addObject:pos.mapViewAnnotation];
            [_map addAnnotation:pos.mapViewAnnotation];
		}
	}
}

- (void)removeAllAnnotations {
    NSArray *toDelete = [NSArray arrayWithArray:_currentAnnotations];
    [_map removeAnnotations:toDelete];
    [_currentAnnotations removeAllObjects];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>) annotation{
    MKAnnotationView *pinView = nil;
    if (annotation != mapView.userLocation) {
        for(MapViewAnnotation *anno in _currentAnnotations) {
            if ([annotation isEqual:anno]) {
                if (anno.image != nil) {
                    pinView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:nil];
                    pinView.image = anno.image;
                } else {
                    pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:nil];
                }
                pinView.canShowCallout = YES;
                if (anno.url != nil || ![anno.url isEqualToString:@""]) {
                    UIButton *btnViewVenue = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
                    pinView.rightCalloutAccessoryView = btnViewVenue;
                }
            }
        }
    }
    else {
        [mapView.userLocation setTitle:@"I am here"];
    }
    return pinView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    MapViewAnnotation *annotation = (MapViewAnnotation*)view.annotation;
    //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:annotation.url]];
    [popUpView openUrlView:annotation.url];
}



@end
