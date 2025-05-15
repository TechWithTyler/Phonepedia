//
//  MessageListInfoView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 1/28/25.
//  Copyright © 2025 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct MessageListInfoView: View {

    var body: some View {
        InfoText("The message list shows a list of all recorded messages. Messages are shown in the list with the caller's name or number, or a generic label if the caller's name or number isn't available or it's a memo/call recording.\nUsing the message list, you can play or erase messages, or call back from the message list.")
    }

}

#Preview {
    MessageListInfoView()
}
