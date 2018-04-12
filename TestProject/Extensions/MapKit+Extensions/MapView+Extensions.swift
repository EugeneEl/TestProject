//
//  MapView+Extensions.swift
//
//  EGS
//
//  Created by Eugene Goloboyar on 20.03.2018.

import Foundation
import MapKit

extension MKMapView {
    
    var isMaxZoom: Bool {
        get {
            return camera.altitude < 1200
        }
    }
    
    func zoomIn(onAnnotation annotation: MKAnnotation, withAnimation: Bool) {
        if isMaxZoom { return }
        var newRegion: MKCoordinateRegion = self.region
        var span: MKCoordinateSpan = self.region.span
        newRegion.center = annotation.coordinate
        span.latitudeDelta *= 0.5
        span.longitudeDelta *= 0.5
        newRegion.span = span
        setRegion(newRegion, animated: withAnimation)
    }
    
    func centerMapOnCoordinate(_ coordinate: CLLocationCoordinate2D, withAnimation: Bool) {
        let center = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        setRegion(region, animated: withAnimation)
    }
    
    func zoomToFitAllAnnotations(_ annotations: [MKAnnotation], animated: Bool = false) {
        var zoomRect = MKMapRectNull
        for annotation in annotations {
            let mapPoint = MKMapPointForCoordinate(annotation.coordinate)
            let pointRect = MKMapRectMake(mapPoint.x, mapPoint.y, 0.1, 0.1)
            zoomRect = MKMapRectUnion(zoomRect, pointRect)
        }
        
        setVisibleMapRect(zoomRect, animated: animated)
    }
}
