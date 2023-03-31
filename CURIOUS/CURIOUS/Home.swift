//
//  Home.swift
//  CURIOUS
//
//  Created by Syam Shukla on 3/30/23.
//

import SwiftUI

struct Home: View {
    var body: some View {
        VStack{Image(systemName: "brain")
                .imageScale(.large)
                .font(.system(size:25))
                .foregroundColor(.orange)
            Text("cu·​ri·​ous")
                .font(.system(size:25))
                .padding(.top)
            Text("Curious")
                .multilineTextAlignment(.center)
                .font(.system(size:50))
                .foregroundColor(.orange)
            Text("eager to know or learn something")
                .font(.system(size:26))
                //.padding(.system(size:2))
                .padding(.top, -30)
            .padding()
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
