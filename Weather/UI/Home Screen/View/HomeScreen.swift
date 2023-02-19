//
//  HomeScreen.swift
//  Weather
//
//  Created by Tony Ayoub on 2023-02-16.
//

import SwiftUI
import CoreLocation


struct HomeScreen: View {
    @StateObject private var viewModel = HomeScreenViewModel()
    @State private var scale = TemperatureScale.celsius

    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Spacer()
            HStack(alignment: .center, spacing: 16) {
                Image(systemName: "sun.max.fill")
                    .font(.largeTitle)
                Text(viewModel.temperatureText)
                    .font(.largeTitle)
            }
            Text("Sunny outside.\nDon't forget your hat!")
                .font(.body)
                .multilineTextAlignment(.center)
            Spacer()
            
            Picker("Scale:", selection: $scale) {
                ForEach(TemperatureScale.allCases, id: \.self) { value in
                    Text(value.rawValue)
                        .tag(value)
                }
                .onChange(of: scale) { viewModel.scale.send($0) }
            }
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen  ()
    }
}
