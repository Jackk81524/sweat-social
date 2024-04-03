//
//  SplitsFormView.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-04-03.
//

import SwiftUI

struct SplitsFormView: View {
    @State var addSplit = false
    @State var title = "Your Split"
    
    let splits: [Split]
    
    let add: (Split) -> Void
    
    var body: some View {
        
        ZStack {
            FormTemplateView(height:350)
            
            VStack {
                
                HStack{
                    Spacer()
                    Text(title)
                        .font(.system(size:22))
                        .foregroundStyle(.red)
                        .multilineTextAlignment(.center)
                        .bold()
                        .frame(width:320)
                    
                    Button{
                        addSplit.toggle()
                    } label: {
                        Text("+")
                            .font(.system(size:28))
                            .foregroundStyle(.red)
                            .bold()
                    }
                }
                
                if(addSplit){
                    //
                } else {
                    ScrollView{
                        ForEach(splits) { split in
                            Text(split.id)
                                .font(.system(size:22))
                                .foregroundStyle(.black)
                        }
                    }
                }
            }
        }
        
    }
}

#Preview {
    SplitsFormView(splits: [])
}
