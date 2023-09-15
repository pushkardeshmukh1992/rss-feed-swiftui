//
//  AddPublicationsView.swift
//  RSSFeed
//
//  Created by Admin on 15/09/23.
//

import SwiftUI

struct AddPublicationsView: View {
    @ObservedObject var publicationsViewModel: PublicationsViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(publicationsViewModel.publications) { publication in
                        HStack {
                            Text(publication.title)
                            Spacer()
                            
                            if publication.active {
                                Image(systemName: "checkmark")
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            publicationsViewModel.toggleActivePublication(publication: publication)
                            
                        }
                    }
                }
            }
            .frame(maxHeight: .infinity)
            .navigationBarTitle("Select publications you wish to follow", displayMode: .inline)
        }
    }
}

struct AddPublicationsView_Previews: PreviewProvider {
    static var previews: some View {
        AddPublicationsView(publicationsViewModel: PublicationsViewModel())
    }
}
