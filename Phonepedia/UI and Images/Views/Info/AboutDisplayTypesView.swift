//
//  AboutDisplayTypesView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 9/16/24.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI

struct AboutDisplayTypesView: View {

    // MARK: - Properties - Dismiss Action

    @Environment(\.dismiss) var dismiss

    // MARK: - Body

    var body: some View {
        NavigationStack {
            List {
                Text("A phone's display, if any, can be one of several types. Expand each section to learn about each one.")
                DisclosureGroup {
                    Text("A segmented monochrome display is a basic LCD display with a font reminiscent of a 7-segment display, although these kinds of displays often have more segments. These displays are often found on very low-end phones and rarely have soft keys.")
                } label: {
                    Text("Segmented Monochrome")
                }
                DisclosureGroup {
                    Text("A traditional monochrome display has at least one line that can display letters, numbers, and special characters. Each line is made up of squares, which contain several small dots, called pixels, and there are often pixels for various pieces of information, such as the date and time. Some phones also have a section for an answering system message counter on the display. These displays may or may not have soft keys.")
                } label: {
                    Text("Traditional Monochrome")
                }
                DisclosureGroup {
                    Text("A full-dot or dot-matrix monochrome display is an LCD display where the entire display or the majority of it is filled with dot pixels. These displays are often found on high-end phones and often have soft keys. The size and amount of pixels determines how small the font can be and how much information can be displayed at once. These displays allow for features like menu icons, display of multiple phonebook/caller ID list entries at once, an answering system message list, and more information on the standby display.")
                } label: {
                    Text("Full-Dot/Dot-Matrix Monochrome")
                }
                DisclosureGroup {
                    Text("A color display is an LCD display that can display colors. These displays are often found on high-end phones and often have soft keys. In addition to the features offered by full-dot monochrome displays, menus can have a color scheme (e.g., white background, black text, blue highlight), and pictures can be assigned to phonebook entries or as the standby display wallpaper.")
                } label: {
                    Text("Color")
                }
                DisclosureGroup {
                    Text("An LED message counter is made up of 2 7-segment LED displays and are used to display the number of answering system messages, the ringer/speaker volume level, and other info. For example, it might display the letter A to indicate the answering system is answering a call, F to indicate the answering system memory is full, or CL to indicate the clock needs to be set. This type of display makes it easy to see how many messages you have at a glance.")
                } label: {
                    Text("LED Message Counter")
                }
                DisclosureGroup {
                    Text("An LCD message counter with status items is a monochrome display with pixels that make up a dual 7-segment display, and pixels for various status items (e.g., a flashing clock to indicate the clock needs to be set). As this type of display usually doesn't have a backlight, it isn't as easy to see how many messages you have at a glance compared to LED message counters.")
                } label: {
                    Text("LCD Message Counter With Status Items")
                }
            }
            .navigationTitle("About Display Types")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Done")
                    }
                }
            }
        }
#if os(macOS)
        .frame(minWidth: 550, maxWidth: 550, minHeight: 350, maxHeight: 350)
#endif
    }
}


#Preview {
    AboutDisplayTypesView()
}
