//
//  SoftKeyExplanationView.swift
//  Phone Booth
//
//  Created by Tyler Sheft on 8/2/23.
//  Copyright © 2023 SheftApps. All rights reserved.
//

import SwiftUI

struct SoftKeyExplanationView: View {
    var body: some View {
		HStack {
			Image(systemName: "info.circle")
			Text("Soft keys are unlabeled buttons which have different functions displayed next to or above them on the display depending on what menu or screen is displayed. When nothing is displayed next to or above a soft key, it has no function at this time.")
		}
			.font(.footnote)
			.foregroundStyle(.secondary)
    }
}

#Preview {
    SoftKeyExplanationView()
}
