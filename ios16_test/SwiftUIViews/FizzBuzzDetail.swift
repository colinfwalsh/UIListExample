//
//  FizzBuzzDetail.swift
//  ios16_test
//
//  Created by Colin Walsh on 6/7/22.
//

import SwiftUI

struct FizzBuzzDetail: View {
    let index: Int
    let text: String
    
    var body: some View {
        VStack(spacing: 20){
            VStack {
                if let val = Int(text),
                   val == index {
                    Text("Default")
                } else {
                    Text(text)
                }
            }
            .font(.title.bold())
            
            Text(String(index))
        }
        .font(.title)
    }
}

struct FizzBuzzDetail_Previews: PreviewProvider {
    static var previews: some View {
        FizzBuzzDetail(index: 0, text: "FizzBuzz")
    }
}
