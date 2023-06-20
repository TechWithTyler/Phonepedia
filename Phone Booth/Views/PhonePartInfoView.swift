//
//  PhoneColorInfoView.swift
//  Phone Booth
//
//  Created by Tyler Sheft on 6/19/23.
//

import SwiftUI

struct PhonePartInfoView: View {

	var phone: Phone

    var body: some View {
		List {
			PhonePartInfoRowView(color: phone.baseColor, part: "Base")
			if phone.hasCordedReceiver {
				PhonePartInfoRowView(color: phone.cordedReceiverColor, part: "Corded Receiver")
			}
			ForEach(0..<phone.numberOfCordlessHandsets, id: \.self) { handsetNumber in
				PhonePartInfoRowView(color: phone.cordlessHandsetColors[handsetNumber], part: "Handset \(handsetNumber+1)")
				if handsetNumber + 1 > 1 {
					PhonePartInfoRowView(color: phone.chargerColors[handsetNumber-1], part: "Charger \(handsetNumber)")
				}
			}
		}
    }
}

#Preview {
	PhonePartInfoView(phone: Phone.preview)
}
