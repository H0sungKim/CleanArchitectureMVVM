//
//  CatResponseDTO.swift
//  DataLayer
//
//  Created by 김호성 on 2025.03.03.
//

import DomainLayer

import Foundation

public struct CatResponseDTO: DTO {
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
    
    init(entity: CatEntity) {
        self.id = nil
        self.url = entity.imageUrl?.absoluteString
        self.width = Int(entity.size.width)
        self.height = Int(entity.size.height)
        self.breeds = [
            Breed(
                weight: nil,
                id: nil,
                name: entity.species,
                cfa_url: nil,
                vetstreet_url: nil,
                temperament: entity.features,
                origin: nil,
                country_codes: nil,
                country_code: nil,
                description: nil,
                life_span: nil,
                indoor: nil,
                lap: nil,
                alt_names: nil,
                adaptability: nil,
                affection_level: nil,
                child_friendly: nil,
                dog_friendly: nil,
                energy_level: nil,
                social_needs: nil,
                stranger_friendly: nil,
                vocalisation: nil,
                experimental: nil,
                hairless: nil,
                natural: nil,
                rare: nil,
                rex: nil,
                suppressed_tail: nil,
                short_legs: nil,
                wikipedia_url: entity.wikipedia?.absoluteString,
                hypoallergenic: nil,
                reference_image_id: nil
            )
        ]
    }
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
