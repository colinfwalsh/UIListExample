//
//  ContentView.swift
//  ios16_test
//
//  Created by Colin Walsh on 6/7/22.
//

import SwiftUI

struct ContentView: View {
    
    func makeText(with item: Int) -> String {
        if item % 3 == 0 && item % 5 == 0 {
            return "FizzBuzz"
        } else if item % 3 == 0 {
            return "Fizz"
        } else if item % 5 == 0 {
            return "Buzz"
        } else {
            return String(item)
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                UIList(Array(0..<1000)) { item in
                    NavigationLink(destination: FizzBuzzDetail(index: item, text: makeText(with: item))) {
                        TextCell(text: makeText(with: item))
                    }
                }
                .onPrefetch { row in
                    print(row)
                }
                .foregroundColor(.black)
                
            }
            .navigationTitle("FizzBuzz")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
