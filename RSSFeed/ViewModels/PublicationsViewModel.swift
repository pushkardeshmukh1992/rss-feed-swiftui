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
        publications = [
            DataUtil.publication1,
            DataUtil.publication2,
            DataUtil.publication3
        ]
    }
    
    func getPublications() -> [Publication] {
        publications
    }
}


