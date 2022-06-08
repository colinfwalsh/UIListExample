//
//  TextCell.swift
//  ios16_test
//
//  Created by Colin Walsh on 6/7/22.
//

import SwiftUI

struct TextCell: View {
    let text: String
    
    var body: some View {
        HStack {
            Text(text)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.blue)
        }
        .frame(height: 100)
    }
}

struct TextCell_Previews: PreviewProvider {
    static var previews: some View {
        TextCell(text: "Test")
    }
}
