//
//  AddPublicationsView.swift
//  RSSFeed
//
//  Created by Admin on 15/09/23.
//

import SwiftUI

struct AddPublicationsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var publicationsViewModel: PublicationsViewModel
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Please select publications which you wish to follow")
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, 24)
                    .font(.system(size: 20))
                    .fontWeight(.medium)
                
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
                .scrollContentBackground(.hidden)
                
            }
            .frame(maxHeight: .infinity)
            .navigationBarTitle("Publications", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "xmark")
            }))
        }
        
    }
}

struct AddPublicationsView_Previews: PreviewProvider {
    static var previews: some View {
        AddPublicationsView(publicationsViewModel: PublicationsViewModel())
    }
}
