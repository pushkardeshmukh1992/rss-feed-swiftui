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
            Text(publication.title)
        }
        
    }
}

struct PublicationListRowView_Previews: PreviewProvider {
    static var previews: some View {
        PublicationListRowView(publication: DataUtil.publication1)
    }
}
