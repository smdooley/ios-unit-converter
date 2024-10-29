//
//  SimpleView.swift
//  UnitConverter
//
//  Created by Sean Dooley on 29/10/2024.
//

import SwiftUI

struct SimpleView: View {
    @State private var inputAmount = 0.0
    @State private var inputUnit = "meters"
    @State private var outputUnit = "meters"
    
    let lengthOptions = ["meters", "kilometers", "feet", "yards", "miles"]
    let unitConversionFactors: [String: Double] = [
        "meters": 1.0,
        "kilometers": 0.001,
        "feet": 3.28084,
        "yards": 1.09361,
        "miles": 0.000621371
    ]
    
    var convertedValue: Double {
            // Convert input amount to base unit (meters), then to output unit
            let baseValue = inputAmount / unitConversionFactors[inputUnit]!
            return baseValue * unitConversionFactors[outputUnit]!
        }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Input") {
                    TextField(
                        "Amount",
                        value: $inputAmount,
                        format: .number
                    )
                    
                    Picker("Input Unit", selection: $inputUnit) {
                        ForEach(lengthOptions, id: \.self) { option in
                            Text(option)
                        }
                    }
                }
                
                Section("Output") {
                    Picker("Output Unit", selection: $outputUnit) {
                        ForEach(lengthOptions, id: \.self) { option in
                            Text(option)
                        }
                    }
                    
                    Text("\(convertedValue.formatted())")
                }
            }
        }
    }
}

#Preview {
    SimpleView()
}
