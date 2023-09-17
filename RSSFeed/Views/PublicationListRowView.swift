//
//  PublicationListRowView.swift
//  RSSFeed
//
//  Created by Admin on 14/09/23.
//

import SwiftUI

struct PublicationListRowView: View {
    var publication: Publication
    
    var body: some View {
        VStack {
            Image(publication.localImage ?? "")
                .resizable()
                .scaledToFit()
                .padding(0)
                .background(.white.opacity(1))
            
            Text(publication.title)
                .padding(.horizontal, 16)
                .font(.subheadline)
                
        }
        .padding(.vertical, 24)
        
    }
}

struct PublicationListRowView_Previews: PreviewProvider {
    static var previews: some View {
        PublicationListRowView(publication: DataUtil.publication1)
    }
}
