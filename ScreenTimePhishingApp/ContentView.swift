//
//  ContentView.swift
//  ScreenTimePhishingApp
//
//  Created by Lasse von Pfeil on 31.10.22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            StartView()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
