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
    @State var expandSplit = false
    @State var splitName = ""
    
    let splits: [Split]
    @Binding var workouts: [WorkoutExercise]
    @Binding var splitToDelete: String
    
    
    let add: (Split) -> Void
    
    var body: some View {
        
        ZStack {
            FormTemplateView(height:400)
            
            VStack {
                HStack{
                    Spacer()
                    Text(title)
                        .font(.system(size:22))
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                        .bold()
                        //.frame(width:320)
                    Spacer()
                    Button{
                        addSplit.toggle()
                    } label: {
                        Text("+")
                            .font(.system(size:28))
                            .foregroundStyle(.white)
                            .bold()
                    }
                    
                }
                .padding()
                .offset(y:20)
                
                if(addSplit){
                    AddSplitView(workouts: $workouts,showAddForm: $addSplit, add: add)
                        .offset(y:55)
                    
                    Spacer()
                } else {
                    ScrollView{
                        LazyVGrid(columns: [GridItem(.flexible(), spacing: 5), GridItem(.flexible(), spacing: 5)], spacing: 5) {
                            ForEach(splits) { split in
                                ZStack{
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(Color(hex:0xF4F4F4))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 5)
                                                .strokeBorder(Color.black,lineWidth: 2)
                                        )
                                        .frame(width: 140, height: expandSplit ? 130: 80)
                                        .simultaneousGesture(
                                            LongPressGesture(minimumDuration: 0.7)
                                                .onEnded { _ in
                                                    splitToDelete = split.id
                                                    
                                                    let generator = UIImpactFeedbackGenerator(style: .medium)
                                                    generator.impactOccurred()
                                                }
                                                .simultaneously(with: TapGesture().onEnded { _ in
                                                    withAnimation {
                                                        expandSplit.toggle()
                                                    }
                                                })
                                        )

                                    VStack{
                                        Text(split.id)
                                            .font(.system(size:18))
                                            .foregroundStyle(.black)
                                            .padding(.top,2)
                                        if(expandSplit){
                                            ForEach(split.workouts, id: \.self) { workout in
                                                Text(workout)
                                                    .font(.system(size:16))
                                                    .foregroundStyle(.black)
                                                    .padding(1)
                                                    .transition(.opacity)
                                            }
                                            .onAppear {
                                                withAnimation(Animation.easeInOut(duration: 2)) {}
                                            }
                                        }
                                    }
                                }
                                .frame(width: 140, height: 130)
                            }
                        }
                        
                    }
                    .offset(y:40)
                    .frame(maxHeight:275)
                    
                }
                Spacer()
            }
        }
        .frame(width: 350, height: 420)
        .offset(y:-65)
        
    }
}

#Preview {
    SplitsFormView(splits: [], workouts: .constant([]),splitToDelete: .constant("Test")) { _ in
    //
    }
}
