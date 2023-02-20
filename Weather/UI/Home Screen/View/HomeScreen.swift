//
//  HomeScreen.swift
//  Weather
//
//  Created by Tony Ayoub on 2023-02-16.
//

import SwiftUI
import CoreLocation

struct HomeScreen: View {
    @ObservedObject var viewModel: HomeScreenViewModel
    @State private var scale = TemperatureScale.celsius
    @State private var isHidden = false
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Spacer()
            if viewModel.isLoading {
                ProgressView()
            } else {
                Text(viewModel.temperatureText)
                    .font(.largeTitle)
            }
            Spacer()
            Picker("Scale:", selection: $scale) {
                ForEach(TemperatureScale.allCases, id: \.self) { value in
                    Text(value.rawValue)
                        .tag(value)
                }
                .onChange(of: scale) { viewModel.scale.send($0) }
            }
            Spacer()
            Toggle("Use simulated data: ", isOn: $viewModel.simulated)
                .padding()
                .onChange(of: viewModel.simulated) { _ in
                    Task { await viewModel.reload() }
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen(viewModel: .init(locator: GPSLocator(), service: TomorrowWeatherService()))
    }
}
