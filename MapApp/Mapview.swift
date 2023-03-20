//
//  Mapview.swift
//  MapApp
//
//  Created by 菅谷亮太 on 2023/03/15.
//

import SwiftUI
import MapKit

enum MapType{
    case standard
    case satellite
    case hybrid
}

struct Mapview: UIViewRepresentable {
    let searchKey:String
    let mapType:MapType
    func makeUIView(context: Context) -> MKMapView {
        MKMapView()
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        print("検索キーワード:\(searchKey)")
        
        switch mapType{
        case .standard:
            uiView.preferredConfiguration = MKStandardMapConfiguration(elevationStyle: .flat)
        case .satellite:
            uiView.preferredConfiguration=MKImageryMapConfiguration()
        case .hybrid:
            uiView.preferredConfiguration = MKHybridMapConfiguration()
        }
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(searchKey,completionHandler: {(placemarks,error) in
            if let placemarks,
               let firstPlacemarks = placemarks.first,
               let location = firstPlacemarks.location{
                let targetCoordinate = location.coordinate
                print("緯度経度:\(targetCoordinate)")
                
                let pin = MKPointAnnotation()
                pin.coordinate = targetCoordinate
                pin.title = searchKey
                uiView.addAnnotation(pin)
                uiView.region = MKCoordinateRegion(
                    center:targetCoordinate,
                    latitudinalMeters: 500.0,
                    longitudinalMeters: 500.0
                )
            }
            
        })
    }
}

struct Mapview_Previews: PreviewProvider {
    static var previews: some View {
        Mapview(searchKey: "羽田空港",mapType: .standard)
    }
}
