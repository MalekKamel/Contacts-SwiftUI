//
//  ContentView.swift
//
//  Created by Shaban kamel on 30/3/21.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        let vm = HomeVM.build()
        HomeScreen(vm: vm).environmentObject(vm)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}





