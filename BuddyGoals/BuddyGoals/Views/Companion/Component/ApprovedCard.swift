//
//  ApprovedCard.swift
//  BuddyGoals
//
//  Created by I Gede Bagus Wirawan on 21/07/22.
//

import SwiftUI

struct ApprovedCard: View {
    
    //Variable
    @State var imageCard : String
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
                    .background(.gray)
            }
            
            
            Text(milestone)
                .font(.system(size: 15, weight: .bold))
                .lineLimit(2)
                .padding(.trailing, 10)
                .frame(alignment: .leading)
                .foregroundColor(whiteDark)
                

            Spacer()
            
            ZStack {
                
                Image(imageCard)
                    .resizable()
                    .frame(width: 60, height: 60)
                    .cornerRadius(10)
                
                Image(systemName: "hand.thumbsup.fill")
                    .foregroundColor(.black)
                    .padding(5)
                    .background(.white)
                    .cornerRadius(10)
                    .opacity(0.7)
                
            }.padding(.trailing, 15)

            
            
                

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

struct ApprovedCard_Previews: PreviewProvider {
    static var previews: some View {
        //NeedApproveCard(colorCard: Color.black, milestone: "Test", destinationCard: "")
        ApprovedCard(imageCard: "Gusde-Emot", colorCard: whiteDark, milestone: "Test", destinationCard: "")
    }
}
