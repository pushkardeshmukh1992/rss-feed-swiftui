//
//  PublicationsListView.swift
//  RSSFeed
//
//  Created by Admin on 14/09/23.
//

import SwiftUI

struct PublicationsListView: View {
    @StateObject var publicationsViewModel = PublicationsViewModel()
    
    var body: some View {
        NavigationView {
            
            VStack {
                List {
                    ForEach(publicationsViewModel.publications) { publication in
                        NavigationLink {
                            FeedListView(feedViewModel: FeedViewModel(publication: publication))
                        } label: {
                            PublicationListRowView(publication: publication)
                        }
                    }
                }
                .navigationBarTitle("Publications", displayMode: .inline)
            }
            
        }
    }
}

struct PublicationsListView_Previews: PreviewProvider {
    static var previews: some View {
        PublicationsListView()
    }
}
