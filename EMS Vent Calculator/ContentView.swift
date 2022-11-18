//
//  ContentView.swift
//  EMS Vent Calculator
//
//  Created by NICK JENNINGS on 11/15/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var respiratoryRate:Double = 0
    @State private var tidalVolume:Double = 0
    @State private var minuteVolume:Double = 0
    @State private var totalVolume:Double = 0
    @State private var height:Double = 0
    @State private var acidosis: Bool = false
    @State private var gender: String = "Male"
    @State private var feet:Double = 5
    @State private var inches:Double = 0
    @State private var weight:Double = 0
    @State private var ketamineDose:Double = 0
    @State private var vecuroniumDose:Double = 0
    @State private var rocuroniumDose:Double = 0
    @State private var volume:Double = 6
    @State private var idealBodyWeight:Double = 0
    
    @State var genderOptions = ["Male", "Female"]
    @State var feetOptions = [5, 6, 7]
    @State var inchesOptions = Array(0...12)
    @State var weightOptions = [0..<301]
    @State var volumeOptions = ["6", "7", "8"]
    
    
    var body: some View {
        
        VStack {
            
            Text("EMS Vent Calculator")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color.blue)
                .multilineTextAlignment(.center)
                .padding(.vertical, 25.0)
            
            
            // Gender picker
            
            HStack {
                
                Text("Gender")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.trailing)
                
                Picker(
                    selection: $gender,
                    label: Text(""),
                    content: {
                        ForEach(genderOptions.indices) { index in
                            Text(genderOptions[index])
                                .tag(genderOptions[index])
                        }
                    })
                .padding(.horizontal)
                
                .pickerStyle(SegmentedPickerStyle())
                
            }
            .padding(.horizontal)
                
                // Height feet and height inches pickers
                
                
                HStack {
                    
                    Text("Height")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.trailing)
                    
                    
                    Picker("", selection: $feet) {
                            ForEach(feetOptions, id: \.self) {
                                Text("\($0)")
                                
                            }
                        }
                    
                    
                    .pickerStyle(WheelPickerStyle())
                    
                    Text("ft")
                        .font(.subheadline)
                    
                    Picker("", selection: $inches) {
                            ForEach(inchesOptions, id: \.self) {
                                Text("\($0)")
                            }
                        }
                    
                    .pickerStyle(WheelPickerStyle())
                    
                    Text("in")
                        .font(.subheadline)
                    
                    
                }
                .padding(.horizontal)
                
                // Weight Picker
                
                HStack {
                    Text("Weight")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                    
                    Picker(
                        selection: $weight,
                        label: Text(""),
                        content: {
                            ForEach(0..<301) {
                                Text("\($0) kg")
                            }
                            
                        })
                    .pickerStyle(WheelPickerStyle())
                }
                
                
                
                // Metabolic Acidosis Toggle
                Toggle(
                    isOn: $acidosis,
                    label: {
                        Text("Metabolic Acidosis?")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding()
                    })
                .padding(.horizontal)
                .toggleStyle(SwitchToggleStyle(tint: Color.blue))
                
                HStack {
                    Text("")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.trailing)
                    
                    Picker(
                        selection: $volume,
                        label: Text("Tidal Volume"),
                        content: {
                            ForEach(volumeOptions.indices) { index in
                                Text(volumeOptions[index])
                                    .tag(volumeOptions[index])
                            }
                        })
                    .pickerStyle(SegmentedPickerStyle())
                    
                    Text("ml/kg")
                        .font(.title2)
                        .padding(.trailing)
                }
                .padding(.horizontal)
                
            Spacer ()
                
                // Calculate Settings Button
                
                Button(action: {
                    
                    //Button Action which I would like to turn into a func and call the func buttonPressed() but each time I do it breaks the code
                    
                       
                    // Ideal Body Weight Calculation
                    
                    height = feet * 12 + inches - 60
                    
                    if gender == "Male" {
                        idealBodyWeight = height * 2.3 + 50
                    }
                    
                    else {
                        idealBodyWeight = height * 2.3 + 45.5
                    }
                    
                    // this if / else could be rewritten as:
                    // idealBodyWeight = gender=='Male'?height * 2.3 + 50:height * 2.3 + 45.5
                    
                    // Tidal Volume Calculation
                    
                    if volume == 6 {
                        tidalVolume = idealBodyWeight * 6
                    }
                    
                    else if volume == 7 {
                        tidalVolume = idealBodyWeight * 7
                    }
                    
                    else if volume == 8 {
                        
                        tidalVolume = idealBodyWeight * 8
                    }

                    // Easier to write as:
                    // tidalVolume = idealBodyWeight * volume or
                    // if 6..8 ~= volume {
                    //      tidalVolume = idealBodyWeight * volume
                    // }
                    
                    // Minute Volume Calculation
                    
                    minuteVolume = idealBodyWeight / 10
                    
                    // totalVolume Calculation
                    
                    totalVolume = minuteVolume * 1000
                    
                    // Metabolic Acidosis Calcuation
                    
                    if acidosis {
                        totalVolume = idealBodyWeight * 120
                        
                    }
                    
                    if acidosis {
                        minuteVolume = totalVolume / 1000
                    }

                    //this does not need to be separate from the above if statement rewrite as:
                    // if acidosis {
                    //    totalVolume = idealBodyWeight * 120
                    //    minuteVolume = totalVolume / 1000
                    // }

                    
                    // Respiratory Rate Calculation
                    
                    respiratoryRate = totalVolume / tidalVolume
                  
                    
                    // Ketamine Dose Calculation
                    
                    ketamineDose = weight * 2
                    
                    // Vecuronium Dose Calculation
                      
                    vecuroniumDose = weight * 0.1
                    
                    // Rocuronium Dose Calculation
                    
                    rocuroniumDose = weight * 1
                    
                    
                }, label: {
                    Text("Calculate Settings")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .shadow(color: Color.blue.opacity(0.3),         radius: 10, x: 0.0, y: 10)
                    
                })
                .padding(.horizontal)
                
                
                
                // Results
                
                ZStack {
                    Image("Z Vent")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 250.0)
                        .opacity(0.1)
                    
                    
                    
                    VStack {
                        Text("Vent Settings")
                            .font(.title)
                            .padding(.bottom, 25)
                        
                        
                        HStack {
                            VStack {
                                Text("Rate")
                                    .font(.title2)
                                
                                Text(String(respiratoryRate))
                                    .font(.title)
                                
                            }
                            .padding(.horizontal)
                            
                            VStack {
                                Text("Vte")
                                    .font(.title2)
                                
                                Text(String(tidalVolume))
                                    .font(.title)
                                
                            }
                            .padding(.horizontal)
                            
                            VStack {
                                Text("Vmin")
                                    .font(.title2)
                                
                                Text(String(minuteVolume))
                                    .font(.title)
                                
                            }
                            .padding(.leading)
                        }
                        .padding(.bottom)
                        
                        HStack {
                            Text("Ketamine Dose")
                            Text(String(ketamineDose))
                                .font(.title)
                            
                            Text("mg")
                                .font(.title)
                        }
                        
                        HStack {
                            Text("Vecuronium Dose")
                            Text(String(vecuroniumDose))
                                .font(.title)
                            
                            Text("mg")
                                .font(.title)
                        }
                        
                        HStack {
                            Text("Rocuronium Dose")
                            Text(String(rocuroniumDose))
                                .font(.title)
                            
                            Text("mg")
                                .font(.title)
                        }
                        
                        
                    }
                    
                }
            }
            
            
        }
        
        
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
