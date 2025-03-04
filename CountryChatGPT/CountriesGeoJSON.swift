//
//  CountryMap.swift
//  CountryChatGPT
//
//  Created by Tatiana Kornilova on 16.02.2025.
//

import SwiftUI
import MapKit

// MARK: - GeoJSON Data Structures

struct CountriesGeoJSON: Decodable {
    let type: String
    let features: [Feature]
}

struct Feature: Decodable{
    let type: String
    let properties: Properties
    let geometry: Geometry
  
    enum CodingKeys: String, CodingKey {
        case type, properties, geometry
     
    }
}

struct Properties: Decodable {
    let ADMIN: String?
    let ISO_A3: String
    let ISO_A2: String
}

// Geometry with dynamic type handling
struct Geometry: Codable {
   let type: GeometryType
   let coordinates: GeometryCoordinates
   
   // Enum to represent the geometry type
   enum GeometryType: String, Codable {
       case polygon = "Polygon"
       case multiPolygon = "MultiPolygon"
   }
   
   // Enum with associated values for coordinates
   enum GeometryCoordinates {
       case polygon(PolygonCoordinates)
       case multiPolygon(MultiPolygonCoordinates)
   }
   
   // Typealiases for clarity
   typealias PolygonCoordinates = [[[Double]]]       // [ring[point[lon, lat]]]
   typealias MultiPolygonCoordinates = [[[[Double]]] ]// [polygon[ring[point[lon, lat]]]]
   
   // Coding keys
   enum CodingKeys: String, CodingKey {
       case type
       case coordinates
   }
   
   // Custom decoding
   init(from decoder: Decoder) throws {
       let container = try decoder.container(keyedBy: CodingKeys.self)
       let type = try container.decode(GeometryType.self, forKey: .type)
       
       switch type {
       case .polygon:
           let coords = try container.decode(PolygonCoordinates.self, forKey: .coordinates)
           self.type = type
           self.coordinates = .polygon(coords)
           
       case .multiPolygon:
           let coords = try container.decode(MultiPolygonCoordinates.self, forKey: .coordinates)
           self.type = type
           self.coordinates = .multiPolygon(coords)
       }
   }
   
   // Custom encoding
   func encode(to encoder: Encoder) throws {
       var container = encoder.container(keyedBy: CodingKeys.self)
       try container.encode(type, forKey: .type)
       
       switch coordinates {
       case .polygon(let coords):
           try container.encode(coords, forKey: .coordinates)
       case .multiPolygon(let coords):
           try container.encode(coords, forKey: .coordinates)
       }
   }
}

extension Geometry {
    func toPolygons() ->[[CLLocationCoordinate2D]] {
        var polygons: [[CLLocationCoordinate2D]] = []
        
        switch coordinates {
        case .polygon(let rings):
            var coordinates2D: [CLLocationCoordinate2D] = []
            for point in rings[0] { // First ring only for simplicity
                let coordinate = CLLocationCoordinate2D(latitude: point[1], longitude: point[0])
                coordinates2D.append(coordinate)
            }
            polygons.append(coordinates2D)
           
        case .multiPolygon(let multiRings):
            for rings in multiRings {
                var coordinates2D: [CLLocationCoordinate2D] = []
                for point in rings[0] { // First ring of each polygon
                    let coordinate = CLLocationCoordinate2D(latitude: point[1], longitude: point[0])
                    coordinates2D.append(coordinate)
                }
                polygons.append(coordinates2D)
            }
        }
        
        return polygons
    }
}
