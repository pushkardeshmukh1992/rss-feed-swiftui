//
//  PublicationsViewModel.swift
//  RSSFeed
//
//  Created by Admin on 14/09/23.
//

import Foundation

class PublicationsViewModel: ObservableObject {
    @Published var publications = [Publication]()
    
    init() {
        publications.append(
            DataUtil.publication1
        )
    }
    
    func getPublications() -> [Publication] {
        publications
    }
}


