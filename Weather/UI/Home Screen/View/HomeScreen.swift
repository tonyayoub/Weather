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
            Picker("Scale:", selection: $viewModel.scale) {
                ForEach(TemperatureScale.allCases, id: \.self) { value in
                    Text(value.rawValue)
                        .tag(value)
                }
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
