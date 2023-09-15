//
//  PublicationsListView.swift
//  RSSFeed
//
//  Created by Admin on 14/09/23.
//

import SwiftUI

struct PublicationsListView: View {
    @State var showAddView = false
    
    @StateObject var publicationsViewModel = PublicationsViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(publicationsViewModel.publications) { publication in
                        if publication.active {
                            NavigationLink {
                                FeedListView(feedViewModel: FeedViewModel(publication: publication))
                            } label: {
                                PublicationListRowView(publication: publication)
                            }
                        }
                    }
                }
                .navigationBarTitle("Publications", displayMode: .inline)
            }
            .overlay(
                Button {
                    showAddView.toggle()
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 48, height: 48)
                }
                .accentColor(Color(ColorUtil.PrimaryLightBlackDarkWhite))
                .padding(.trailing, 32)
                .frame(width: 48, height: 48)
                , alignment: .bottomTrailing
            )
        }
        .sheet(isPresented: $showAddView) {
            AddPublicationsView(publicationsViewModel: publicationsViewModel)
        }
    }
}

struct PublicationsListView_Previews: PreviewProvider {
    static var previews: some View {
        PublicationsListView()
    }
}
