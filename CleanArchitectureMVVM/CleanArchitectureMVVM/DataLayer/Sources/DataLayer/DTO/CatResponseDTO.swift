//
//  CatResponseDTO.swift
//  DataLayer
//
//  Created by 김호성 on 2025.03.03.
//

import DomainLayer

import Foundation

public struct CatResponseDTO: Codable {
    struct Breed: Codable {
        struct Weight: Codable {
            let imperial: String?
            let metric: String?
        }
        
        let weight: Weight?
        let id: String?
        let name: String?
        let cfa_url: String?
        let vetstreet_url: String?
        let temperament: String?
        let origin: String?
        let country_codes: String?
        let country_code: String?
        let description: String?
        let life_span: String?
        let indoor: Int?
        let lap: Int?
        let alt_names: String?
        let adaptability: Int?
        let affection_level: Int?
        let child_friendly: Int?
        let dog_friendly: Int?
        let energy_level: Int?
        let social_needs: Int?
        let stranger_friendly: Int?
        let vocalisation: Int?
        let experimental: Int?
        let hairless: Int?
        let natural: Int?
        let rare: Int?
        let rex: Int?
        let suppressed_tail: Int?
        let short_legs: Int?
        let wikipedia_url: String?
        let hypoallergenic: Int?
        let reference_image_id: String?
    }
    
    let id: String?
    let url: String?
    let width: Int?
    let height: Int?
    let breeds: [Breed]?
}

extension CatResponseDTO {
    var entity: CatEntity {
        get {
            return CatEntity(
                imageUrl: URL(string: self.url ?? ""),
                size: {
                    guard let width = self.width, let height = self.height else {
                        return .zero
                    }
                    return CGSize(width: width, height: height)
                }(),
                species: self.breeds?.first?.name ?? "",
                features: self.breeds?.first?.temperament ?? "",
                wikipedia: URL(string: self.breeds?.first?.wikipedia_url ?? "")
            )
        }
    }
}
