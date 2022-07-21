//
//  WaitingSubmissionCard.swift
//  BuddyGoals
//
//  Created by I Gede Bagus Wirawan on 21/07/22.
//

import SwiftUI

struct WaitingSubmissionCard: View {
    
    //Variable
    //@State var imageCard : String
    @State var colorCard : Color
    @State var milestone : String
    @State var destinationCard : String
    
    var body: some View {
        
        //Card
        HStack{
            VStack{
                Rectangle()
                    .padding(.trailing, 10)
                    .padding(.leading, 10)
                    .frame(width: 20, height: 80)
                    .background(colorCard)
            }
            
            
            Text(milestone)
                .font(.system(size: 15, weight: .bold))
                .lineLimit(2)
                .padding(.trailing, 10)
                .frame(alignment: .leading)
                .foregroundColor(Color.black)
            
            Spacer()
            
        }
        .background(.white)
        .cornerRadius(13)
        .padding(.bottom, 20)
        .padding(.trailing, 30)
        .padding(.leading, 30)
        //.padding(30) //safe area
        .shadow(color: Color.gray.opacity(0.275), radius: 8, x: 2, y: 4)
        //Close of Card
    }
}

struct WaitingSubmissionCard_Previews: PreviewProvider {
    static var previews: some View {
        WaitingSubmissionCard(colorCard: Color.black, milestone: "Test", destinationCard: "")
        //WaitingSubmissionCard(imageCard: "Gusde-Emot", colorCard: Color.black, milestone: "Test", destinationCard: "")
    }
}
