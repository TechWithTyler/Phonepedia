//
//  AntennaInfoView.swift
//  Phone Booth
//
//  Created by Tyler Sheft on 10/11/23.
//  Copyright © 2023 SheftApps. All rights reserved.
//

import SwiftUI

struct AntennaInfoView: View {
    var body: some View {
		HStack {
			Image(systemName: "info.circle")
			Text("A telescopic antenna can be extended for more range. These kinds of antennas are most commonly seen on 46-49MHz phones and are sometimes removable.")
		}
    }
}

#Preview {
    AntennaInfoView()
}
