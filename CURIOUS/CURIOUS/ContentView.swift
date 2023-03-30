//
//  ContentView.swift
//  CURIOUS
//
//  Created by Syam Shukla on 3/30/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "brain")
                .imageScale(.large)
                .foregroundColor(.orange)
            Text("Engage Your Mind")
                .bold()
        }
        
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}
