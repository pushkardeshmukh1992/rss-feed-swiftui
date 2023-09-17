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
        publications = DataUtil.allPublications
    }
    
    func toggleActivePublication(publication: Publication) {
        publications = publications.map { pub in
            var tempPublication = pub
            
            if pub.id == publication.id {
                tempPublication.active = !tempPublication.active
            }
            
            return tempPublication
        }
    }
    
    func isAnyPublicationActive() -> Bool {
        let publication = publications.first { $0.active }
        return publication != nil
    }
}


