//
//  ContentView.swift
//  UnitConverter
//
//  Created by Sean Dooley on 29/10/2024.
//

import SwiftUI

struct ContentView: View {
    // State properties to store the input, selected units, and result
    @State private var inputAmount = 0.0
    @State private var inputUnit = "Meters"
    @State private var outputUnit = "Meters"
    
    // Define units and conversion factors relative to meters
    let lengthUnits = ["Meters", "Kilometers", "Feet", "Yards", "Miles"]
    let unitConversionFactors: [String: Double] = [
        "Meters": 1.0,
        "Kilometers": 0.001,
        "Feet": 3.28084,
        "Yards": 1.09361,
        "Miles": 0.000621371
    ]
    
    var convertedValue: Double {
        // Convert input amount to base unit (meters), then to output unit
        let baseValue = inputAmount / unitConversionFactors[inputUnit]!
        return baseValue * unitConversionFactors[outputUnit]!
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section("Input") {
                    // Input text field
                    TextField("Amount to convert", value: $inputAmount, format: .number)
                        .keyboardType(.decimalPad)
                    
                    // Input unit picker
                    Picker("From", selection: $inputUnit) {
                        ForEach(lengthUnits, id: \.self) { unit in
                            Text(unit)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Output") {
                    // Output unit picker
                    Picker("To", selection: $outputUnit) {
                        ForEach(lengthUnits, id: \.self) { unit in
                            Text(unit)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    // Display the result
                    Text("\(convertedValue.formatted())")
                }
            }
            .navigationTitle("Unit Converter")
        }
    }
}

#Preview {
    ContentView()
}
