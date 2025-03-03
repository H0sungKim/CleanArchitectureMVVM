//
//  CatEntity.swift
//  CleanArchitectureMVVM
//
//  Created by 김호성 on 2025.03.03.
//

import Foundation

struct CatEntity {
    let imageUrl: URL?
    let size: CGSize
    let species: String
    let features: String
    let wikipedia: URL?
    
    init(catResponseDTO: CatResponseDTO) {
        self.imageUrl = URL(string: catResponseDTO.url ?? "")
        if let width = catResponseDTO.width, let height = catResponseDTO.height {
            self.size = CGSize(width: width, height: height)
        } else {
            self.size = .zero
        }
        self.species = catResponseDTO.breeds?.first?.name ?? ""
        self.features = catResponseDTO.breeds?.first?.temperament ?? ""
        self.wikipedia = URL(string: catResponseDTO.breeds?.first?.wikipedia_url ?? "")
    }
}
