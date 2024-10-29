//
//  ContentView.swift
//  UnitConverter
//
//  Created by Sean Dooley on 29/10/2024.
//

import SwiftUI

struct ContentView: View {
    // Define categories and associated units
    let categories = ["Length", "Volume", "Temperature"]
    
    // Define conversion units for each category
    let lengthUnits = ["Meters", "Kilometers", "Feet", "Yards", "Miles"]
    let volumeUnits = ["Milliliters", "Liters", "Cups", "Pints", "Gallons"]
    let temperatureUnits = ["Celsius", "Fahrenheit", "Kelvin"]
    
    // Conversion factors for length and volume, relative to base units
    let lengthConversionFactors: [String: Double] = [
        "Meters": 1.0, "Kilometers": 0.001, "Feet": 3.28084,
        "Yards": 1.09361, "Miles": 0.000621371
    ]
    let volumeConversionFactors: [String: Double] = [
        "Milliliters": 1.0, "Liters": 0.001, "Cups": 0.00422675,
        "Pints": 0.00211338, "Gallons": 0.000264172
    ]
    
    // Temperature conversion is handled separately as it’s non-linear
    func convertTemperature(value: Double, from: String, to: String) -> Double {
        if from == to { return value }
        
        if from == "Celsius" && to == "Fahrenheit" { return (value * 9/5) + 32 }
        if from == "Celsius" && to == "Kelvin" { return value + 273.15 }
        
        if from == "Fahrenheit" && to == "Celsius" { return (value - 32) * 5/9 }
        if from == "Fahrenheit" && to == "Kelvin" { return (value - 32) * 5/9 + 273.15 }
        
        if from == "Kelvin" && to == "Celsius" { return value - 273.15 }
        if from == "Kelvin" && to == "Fahrenheit" { return (value - 273.15) * 9/5 + 32 }
        
        return value
    }
    
    // State properties for user selection
    @State private var selectedCategory = "Length" {
        didSet {
            updateUnits()
        }
    }
    @State private var inputUnit = "Meters"
    @State private var outputUnit = "Meters"
    @State private var inputAmount = 0.0
    
    // Computed property for current units based on selected category
    var currentUnits: [String] {
        switch selectedCategory {
            case "Length": return lengthUnits
            case "Volume": return volumeUnits
            case "Temperature": return temperatureUnits
            default: return []
        }
    }
    
    // Computed property for conversion result
    var convertedValue: Double {
        switch selectedCategory {
            case "Length":
                let baseValue = inputAmount / (lengthConversionFactors[inputUnit] ?? 1.0)
                return baseValue * (lengthConversionFactors[outputUnit] ?? 1.0)
            case "Volume":
                let baseValue = inputAmount / (volumeConversionFactors[inputUnit] ?? 1.0)
                return baseValue * (volumeConversionFactors[outputUnit] ?? 1.0)
            case "Temperature":
                return convertTemperature(value: inputAmount, from: inputUnit, to: outputUnit)
            default:
                return 0.0
        }
    }
    
    // Function to update input and output units when category changes
    func updateUnits() {
        inputUnit = currentUnits.first ?? ""
        outputUnit = currentUnits.first ?? ""
    }
    
    var body: some View {
        NavigationView {
            Form {
                // Category Picker
                Section("Category") {
                    Picker("Select Category", selection: $selectedCategory) {
                        ForEach(categories, id: \.self) { category in
                            Text(category)
                        }
                    }
                }
                
                // Input Amount and Units
                Section("Input") {
                    TextField("Amount", value: $inputAmount, format: .number)
                        .keyboardType(.decimalPad)
                    
                    Picker("From", selection: $inputUnit) {
                        ForEach(currentUnits, id: \.self) { unit in
                            Text(unit)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                // Output Units and Converted Value
                Section("Output") {
                    Picker("To", selection: $outputUnit) {
                        ForEach(currentUnits, id: \.self) { unit in
                            Text(unit)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    Text("\(convertedValue.formatted()) ")
                }
            }
            .navigationTitle("Unit Converter")
        }
        .onAppear {
            updateUnits()
        }
    }
}

#Preview {
    ContentView()
}
