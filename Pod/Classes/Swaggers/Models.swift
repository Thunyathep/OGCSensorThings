// Models.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation

protocol JSONEncodable {
    func encodeToJSON() -> AnyObject
}

public class Response<T> {
    public let statusCode: Int
    public let header: [String: String]
    public let body: T

    public init(statusCode: Int, header: [String: String], body: T) {
        self.statusCode = statusCode
        self.header = header
        self.body = body
    }

    public convenience init(response: NSHTTPURLResponse, body: T) {
        let rawHeader = response.allHeaderFields
        var header = [String:String]()
        for (key, value) in rawHeader {
            header[key as! String] = value as? String
        }
        self.init(statusCode: response.statusCode, header: header, body: body)
    }
}

private var once = dispatch_once_t()
class Decoders {
    static private var decoders = Dictionary<String, ((AnyObject) -> AnyObject)>()
    
    static func addDecoder<T>(clazz clazz: T.Type, decoder: ((AnyObject) -> T)) {
        let key = "\(T.self)"
        decoders[key] = { decoder($0) as! AnyObject }
    }
    
    static func decode<T>(clazz clazz: [T].Type, source: AnyObject) -> [T] {
        let array = source as! [AnyObject]
        return array.map { Decoders.decode(clazz: T.self, source: $0) }
    }
    
    static func decode<T, Key: Hashable>(clazz clazz: [Key:T].Type, source: AnyObject) -> [Key:T] {
        let sourceDictinoary = source as! [Key: AnyObject]
        var dictionary = [Key:T]()
        for (key, value) in sourceDictinoary {
            dictionary[key] = Decoders.decode(clazz: T.self, source: value)
        }
        return dictionary
    }
    
    static func decode<T>(clazz clazz: T.Type, source: AnyObject) -> T {
        initialize()
        if source is T {
            return source as! T
        }
        
        let key = "\(T.self)"
        if let decoder = decoders[key] {
           return decoder(source) as! T
        } else {
            fatalError("Source \(source) is not convertible to type \(clazz): Maybe swagger file is insufficient")
        }
    }

    static func decodeOptional<T>(clazz clazz: T.Type, source: AnyObject?) -> T? {
        if source is NSNull {
            return nil
        }
        return source.map { (source: AnyObject) -> T in
            Decoders.decode(clazz: clazz, source: source)
        }
    }

    static func decodeOptional<T>(clazz clazz: [T].Type, source: AnyObject?) -> [T]? {
        if source is NSNull {
            return nil
        }
        return source.map { (someSource: AnyObject) -> [T] in
            Decoders.decode(clazz: clazz, source: someSource)
        }
    }

    static func decodeOptional<T, Key: Hashable>(clazz clazz: [Key:T].Type, source: AnyObject?) -> [Key:T]? {
        if source is NSNull {
            return nil
        }
        return source.map { (someSource: AnyObject) -> [Key:T] in
            Decoders.decode(clazz: clazz, source: someSource)
        }
    }
	
    static private func initialize() {
        dispatch_once(&once) {
            let formatters = [
                "yyyy-MM-dd",
                "yyyy-MM-dd'T'HH:mm:ssZZZZZ",
                "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ",
                "yyyy-MM-dd'T'HH:mm:ss'Z'"
            ].map { (format: String) -> NSDateFormatter in
                let formatter = NSDateFormatter()
                formatter.dateFormat = format
                return formatter
            }
            // Decoder for NSDate
            Decoders.addDecoder(clazz: NSDate.self) { (source: AnyObject) -> NSDate in
               if let sourceString = source as? String {
                    for formatter in formatters {
                        if let date = formatter.dateFromString(sourceString) {
                            return date
                        }
                    }
                
                }
                if let sourceInt = source as? Int {
                    // treat as a java date
                    return NSDate(timeIntervalSince1970: Double(sourceInt / 1000) )
                }
                fatalError("formatter failed to parse \(source)")
            } 

			// Decoder for [Datastream]
            Decoders.addDecoder(clazz: [Datastream].self) { (source: AnyObject) -> [Datastream] in
                return Decoders.decode(clazz: [Datastream].self, source: source)
            }
			// Decoder for Datastream
            Decoders.addDecoder(clazz: Datastream.self) { (source: AnyObject) -> Datastream in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = Datastream()
                instance.iotId = Decoders.decodeOptional(clazz: AnyObject.self, source: sourceDictionary["@iot.id"])
                instance.iotSelfLink = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["@iot.selfLink"])
                instance.iotNavigationLink = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["@iot.navigationLink"])
                instance.description = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["Description"])
                instance.thing = Decoders.decodeOptional(clazz: Thing.self, source: sourceDictionary["Thing"])
                instance.observedProperty = Decoders.decodeOptional(clazz: ObservedProperty.self, source: sourceDictionary["ObservedProperty"])
                instance.observations = Decoders.decodeOptional(clazz: Array.self, source: sourceDictionary["Observations"])
                return instance
            }
			

			// Decoder for [Entity]
            Decoders.addDecoder(clazz: [Entity].self) { (source: AnyObject) -> [Entity] in
                return Decoders.decode(clazz: [Entity].self, source: source)
            }
			// Decoder for Entity
            Decoders.addDecoder(clazz: Entity.self) { (source: AnyObject) -> Entity in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = Entity()
                instance.iotId = Decoders.decodeOptional(clazz: AnyObject.self, source: sourceDictionary["@iot.id"])
                instance.iotSelfLink = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["@iot.selfLink"])
                instance.iotNavigationLink = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["@iot.navigationLink"])
                return instance
            }
			

			// Decoder for [FeatureOfInterest]
            Decoders.addDecoder(clazz: [FeatureOfInterest].self) { (source: AnyObject) -> [FeatureOfInterest] in
                return Decoders.decode(clazz: [FeatureOfInterest].self, source: source)
            }
			// Decoder for FeatureOfInterest
            Decoders.addDecoder(clazz: FeatureOfInterest.self) { (source: AnyObject) -> FeatureOfInterest in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = FeatureOfInterest()
                instance.iotId = Decoders.decodeOptional(clazz: AnyObject.self, source: sourceDictionary["@iot.id"])
                instance.iotSelfLink = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["@iot.selfLink"])
                instance.iotNavigationLink = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["@iot.navigationLink"])
                instance.description = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["Description"])
                instance.geometry = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["Geometry"])
                instance.observations = Decoders.decodeOptional(clazz: Array.self, source: sourceDictionary["Observations"])
                return instance
            }
			

			// Decoder for [Location]
            Decoders.addDecoder(clazz: [Location].self) { (source: AnyObject) -> [Location] in
                return Decoders.decode(clazz: [Location].self, source: source)
            }
			// Decoder for Location
            Decoders.addDecoder(clazz: Location.self) { (source: AnyObject) -> Location in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = Location()
                instance.iotId = Decoders.decodeOptional(clazz: AnyObject.self, source: sourceDictionary["@iot.id"])
                instance.iotSelfLink = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["@iot.selfLink"])
                instance.iotNavigationLink = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["@iot.navigationLink"])
                instance.time = Decoders.decodeOptional(clazz: NSDate.self, source: sourceDictionary["Time"])
                instance.geometry = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["Geometry"])
                instance.things = Decoders.decodeOptional(clazz: Array.self, source: sourceDictionary["Things"])
                return instance
            }
			

			// Decoder for [Observation]
            Decoders.addDecoder(clazz: [Observation].self) { (source: AnyObject) -> [Observation] in
                return Decoders.decode(clazz: [Observation].self, source: source)
            }
			// Decoder for Observation
            Decoders.addDecoder(clazz: Observation.self) { (source: AnyObject) -> Observation in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = Observation()
                instance.iotId = Decoders.decodeOptional(clazz: AnyObject.self, source: sourceDictionary["@iot.id"])
                instance.iotSelfLink = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["@iot.selfLink"])
                instance.iotNavigationLink = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["@iot.navigationLink"])
                instance.time = Decoders.decodeOptional(clazz: NSDate.self, source: sourceDictionary["Time"])
                instance.resultType = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["ResultType"])
                instance.resultValue = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["ResultValue"])
                instance.datastream = Decoders.decodeOptional(clazz: Datastream.self, source: sourceDictionary["Datastream"])
                instance.featureOfInterest = Decoders.decodeOptional(clazz: FeatureOfInterest.self, source: sourceDictionary["FeatureOfInterest"])
                instance.sensor = Decoders.decodeOptional(clazz: Sensor.self, source: sourceDictionary["Sensor"])
                return instance
            }
			

			// Decoder for [ObservedProperty]
            Decoders.addDecoder(clazz: [ObservedProperty].self) { (source: AnyObject) -> [ObservedProperty] in
                return Decoders.decode(clazz: [ObservedProperty].self, source: source)
            }
			// Decoder for ObservedProperty
            Decoders.addDecoder(clazz: ObservedProperty.self) { (source: AnyObject) -> ObservedProperty in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = ObservedProperty()
                instance.iotId = Decoders.decodeOptional(clazz: AnyObject.self, source: sourceDictionary["@iot.id"])
                instance.iotSelfLink = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["@iot.selfLink"])
                instance.iotNavigationLink = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["@iot.navigationLink"])
                instance.URI = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["URI"])
                instance.unitOfMeasurement = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["UnitOfMeasurement"])
                instance.datastreams = Decoders.decodeOptional(clazz: Array.self, source: sourceDictionary["Datastreams"])
                return instance
            }
			

			// Decoder for [Sensor]
            Decoders.addDecoder(clazz: [Sensor].self) { (source: AnyObject) -> [Sensor] in
                return Decoders.decode(clazz: [Sensor].self, source: source)
            }
			// Decoder for Sensor
            Decoders.addDecoder(clazz: Sensor.self) { (source: AnyObject) -> Sensor in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = Sensor()
                instance.iotId = Decoders.decodeOptional(clazz: AnyObject.self, source: sourceDictionary["@iot.id"])
                instance.iotSelfLink = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["@iot.selfLink"])
                instance.iotNavigationLink = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["@iot.navigationLink"])
                instance.metadata = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["Metadata"])
                instance.observations = Decoders.decodeOptional(clazz: Array.self, source: sourceDictionary["Observations"])
                return instance
            }
			

			// Decoder for [Thing]
            Decoders.addDecoder(clazz: [Thing].self) { (source: AnyObject) -> [Thing] in
                return Decoders.decode(clazz: [Thing].self, source: source)
            }
			// Decoder for Thing
            Decoders.addDecoder(clazz: Thing.self) { (source: AnyObject) -> Thing in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = Thing()
                instance.iotId = Decoders.decodeOptional(clazz: AnyObject.self, source: sourceDictionary["@iot.id"])
                instance.iotSelfLink = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["@iot.selfLink"])
                instance.iotNavigationLink = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["@iot.navigationLink"])
                instance.description = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["description"])
                instance.locations = Decoders.decodeOptional(clazz: Array.self, source: sourceDictionary["Locations"])
                instance.datastreams = Decoders.decodeOptional(clazz: Array.self, source: sourceDictionary["Datastreams"])
                return instance
            }
			
        }
    }
}
