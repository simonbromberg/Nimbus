//
//  ContentView.swift
//  Nimbus
//
//  Created by Simon Bromberg on 2022-03-18.
//

import Foundation
import SwiftUI

struct ContentView: View {
    let dataProvider: DataProvider
    @State private var weather: Weather = .placeholder
    @State private var error: Error?
    @State private var isLoading: Bool = false

    var body: some View {
        VStack {
            WeatherView(weather: $weather)
                .onAppear {
                    reload()
                }
                .redacted(reason: weather == .placeholder ? .placeholder : [])
            Button(action: reload) {
                isLoading ? AnyView(ProgressView("Loading…")) : AnyView(Text("Reload"))
            }.disabled(isLoading)
            Text(error?.localizedDescription ?? "")
                .font(.footnote)
                .foregroundColor(Color.red)
                .padding()
        }
    }

    func reload() {
        Task {
            isLoading = true
            do {
                weather = try await dataProvider.getWeather(location: .Toronto)
                error = nil
            } catch {
                self.error = error
            }
            isLoading = false            
        }
    }
}
