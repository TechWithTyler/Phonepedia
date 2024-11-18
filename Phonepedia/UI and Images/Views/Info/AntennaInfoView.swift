//
//  AntennaInfoView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 10/11/23.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct AntennaInfoView: View {
    
	var body: some View {
		InfoText("A telescopic antenna can be extended for more range. These kinds of antennas are most commonly seen on 46-49MHz phones and are sometimes removable.\nA short antenna is often used just for show, with the actual antenna hidden inside the phone. Most cordless phones today lack external antennas entirely.\nA long antenna is used for transmitting purposes. These can still be seen on some bases today, but almost all handsets have either a short, only-for-show external antenna, or none at all.")
	}
    
}

#Preview {
    AntennaInfoView()
}
