//
// Thing.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


public class Thing: JSONEncodable {

    /** ID is the system-generated identifier of an entity. ID is unique among the entities of the same entity type. */
    public var iotId: AnyObject?
    /** Self-Link is the absolute URL of an entity which is unique among all other entities. */
    public var iotSelfLink: String?
    /** Navigation-Link is the relative URL that retrives content of related entities. */
    public var iotNavigationLink: String?
    /** This is the description of the thing entity. The content is open to accommodate changes to SensorML and to support other description languages. */
    public var description: String?
    /** A thing can locate at different geographical positions at different time points (multiple locations). Multiple things can locate at the same location at the same time. A thing may not have a location. */
    public var locations: [Location]?
    /** A thing can have zero-to-many datastreams. A datastream entity can only link to a thing as a collection of observations or properties. */
    public var datastreams: [Datastream]?
    

    public init() {}

    // MARK: JSONEncodable
    func encodeToJSON() -> AnyObject {
        var nillableDictionary = [String:AnyObject?]()
        nillableDictionary["@iot.id"] = self.iotId
        nillableDictionary["@iot.selfLink"] = self.iotSelfLink
        nillableDictionary["@iot.navigationLink"] = self.iotNavigationLink
        nillableDictionary["description"] = self.description
        nillableDictionary["Locations"] = self.locations?.encodeToJSON()
        nillableDictionary["Datastreams"] = self.datastreams?.encodeToJSON()
        let dictionary: [String:AnyObject] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
