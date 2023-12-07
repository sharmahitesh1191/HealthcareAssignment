//
//  TopicsModel.swift
//  HealthcareAssignment
//
//  Created by Hitesh Sharma on 07/12/23.
//

import Foundation

struct Topics: Codable {
    let result: Result

    enum CodingKeys: String, CodingKey {
        case result = "Result"
    }
}

struct Result: Codable {
    let resources: Resources

    enum CodingKeys: String, CodingKey {
        case resources = "Resources"
    }
}

struct Resources: Codable {
    let resource: [Resource]

    enum CodingKeys: String, CodingKey {
        case resource = "Resource"
    }
}

struct Resource: Codable, Identifiable {
    let id: String
    let title: String
    let relatedItems: RelatedItems
    let imageURL: String
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case title = "Title"
        case relatedItems = "RelatedItems"
        case imageURL = "ImageUrl"
    }
}

// MARK: - RelatedItems
struct RelatedItems: Codable {
    let relatedItem: [RelatedItem]

    enum CodingKeys: String, CodingKey {
        case relatedItem = "RelatedItem"
    }
}

struct RelatedItem: Codable, Identifiable {
    let type: TypeEnum
    let id, title: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case type = "Type"
        case id = "Id"
        case title = "Title"
        case url = "Url"
    }
}

enum TypeEnum: String, Codable {
    case topic = "Topic"
}

enum ViewState {
    case loading
    case loaded
    case error
}
