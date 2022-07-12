//
//  CardHomeView.swift
//  BuddyGoals
//
//  Created by I Gede Bagus Wirawan on 28/06/22.
//

import SwiftUI

struct CardHomeView: View {
    //Variable
    @State var imageCard : String
    @State var colorCard : Color
    @State var milestone : String
    @State var destinationCard : String
    
    var body: some View {
        
        //Card
            HStack{
                VStack{
                    Image(imageCard)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.trailing, 10)
                        .padding(.leading, 10)
                        .frame(width: 50, height: 80)
                        .background(colorCard)
                }
                
                
                Text(milestone)
                    .font(.system(size: 17.5, weight: .bold))
                    .padding(.trailing, 10)
                    .frame(alignment: .leading)
                    .foregroundColor(Color.black)

                Spacer()
                
                Image(systemName: "chevron.right")
                    .padding(.trailing, 15)
                    .foregroundColor(Color.gray)

            }
            .background(.white)
            
        .cornerRadius(10)
        .padding()
        .shadow(color: .gray, radius: 5)
        //Close of Card
    }
}

struct CardHomeView_Previews: PreviewProvider {
    static var previews: some View {
        CardHomeView(imageCard: "", colorCard: Color.black, milestone: "Test", destinationCard: "")
    }
}
