//
//  BaseDisplayBacklightButtonsView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 10/3/24.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct BaseDisplayBacklightButtonsView: View {

    @Bindable var phone: Phone

    @EnvironmentObject var dialogManager: DialogManager

    var body: some View {
        Picker("Button Type", selection: $phone.buttonType) {
            Text("Spaced").tag(0)
            Text("Spaced with Click Feel").tag(1)
            Text("Some Spaced, Some Diamond-Cut").tag(2)
            Text("Some Spaced with Click Feel, Some Diamond-Cut").tag(3)
            Text("Diamond-Cut (no space between buttons, click feel)").tag(4)
        }
        Toggle("7 Has Q and 9 Has Z", isOn: phone.baseDisplayType == 0 ? $phone.hasQZ : .constant(true))
        PhoneNumberLetterInfoView()
        Picker(phone.isCordless ? "Display Type (base)" : "Display Type", selection: $phone.baseDisplayType) {
            Text("None").tag(0)
            if phone.hasAnsweringSystem > 0 {
                Text("LED Message Counter").tag(1)
                Text("LCD Message Counter With Status Items").tag(2)
            }
            Text("Monochrome Display (traditional)").tag(3)
            Text("Monochrome Display (full-dot with status items)").tag(4)
            Text("Monochrome Display (full-dot)").tag(5)
            Text("Color Display").tag(6)
        }
        .onChange(of: phone.baseDisplayType) { oldValue, newValue in
            phone.baseDisplayTypeChanged(oldValue: oldValue, newValue: newValue)
        }
        InfoButton(title: "About Display Types…") {
            dialogManager.showingAboutDisplayTypes = true
        }
        if phone.baseDisplayType >= 4 {
            Picker("Main Menu Layout", selection: $phone.baseMainMenuLayout) {
                Text("List").tag(0)
                Text("Carousel").tag(2)
                Text("Grid").tag(3)
            }
        }
        if phone.baseDisplayType > 2 && phone.baseDisplayType < 6 {
            ColorPicker("Base Display Backlight Color", selection: phone.baseDisplayBacklightColorBinding)
        }
        if phone.baseDisplayType >= 3 {
            Toggle("Base Has LED Message Counter In Addition To Display", isOn: $phone.baseHasDisplayAndMessageCounter)
        }
        if phone.baseDisplayType == 1 || phone.baseHasDisplayAndMessageCounter {
            ColorPicker("LED Message Counter Color", selection: phone.baseLEDMessageCounterColorBinding)
        }
        if phone.baseDisplayType > 0 {
            Picker("Base Navigation Button Type", selection: $phone.baseNavigatorKeyType) {
                Text("None").tag(0)
                Text("Up/Down").tag(1)
                Text("Up/Down/Left/Right").tag(3)
            }
            .onChange(of: phone.baseNavigatorKeyType) { oldValue, newValue in
                phone.baseNavigatorKeyTypeChanged(oldValue: oldValue, newValue: newValue)
            }
            if phone.baseNavigatorKeyType > 0 {
                Picker("Base Navigation Button Center Button", selection: $phone.baseNavigatorKeyCenterButton) {
                    Text("None").tag(0)
                    Text("Select").tag(1)
                    Text("Menu/Select").tag(2)
                    if phone.hasAnsweringSystem == 1 || phone.hasAnsweringSystem == 3 {
                        Text("Play/Stop").tag(3)
                        Text("Play/Select").tag(4)
                        Text("Play/Stop/Select").tag(5)
                    }
                    Text("Other Function").tag(6)
                }
                Toggle("Base Navigation Button Up/Down for Volume", isOn: $phone.baseNavigatorKeyUpDownVolume)
                if phone.hasAnsweringSystem == 1 || phone.hasAnsweringSystem == 3 {
                    Toggle("Base Navigation Button Left/Right for Repeat/Skip", isOn: $phone.baseNavigatorKeyLeftRightRepeatSkip)
                }
                Toggle("Base Navigation Button Standby Shortcuts", isOn: $phone.baseNavigatorKeyStandbyShortcuts)
            }
            if phone.baseDisplayType > 2 {
                Stepper("Base Soft Keys (bottom): \(phone.baseSoftKeysBottom)", value: $phone.baseSoftKeysBottom, in: 0...4)
                    .onChange(of: phone.baseSoftKeysBottom) { oldValue, newValue in
                        phone.baseSoftKeysBottomChanged(oldValue: oldValue, newValue: newValue)
                    }
                Stepper("Base Soft Keys (side): \(phone.baseSoftKeysSide) On Each Side (\(phone.baseSoftKeysSide * 2) total)", value: $phone.baseSoftKeysSide, in: 0...5)
                    .onChange(of: phone.baseSoftKeysSide) { oldValue, newValue in
                        phone.baseSoftKeysSideChanged(oldValue: oldValue, newValue: newValue)
                    }
                SoftKeyExplanationView()
                InfoText("Side soft keys are often used for programmable functions or speed dials in standby or one-touch menu selections in menus. For example, in a menu with 5 options, instead of scrolling up or down through the menu and then pressing the select button, you can press the corresponding side soft key. Side soft keys are often seen on business-grade phones, especially those used on a system with multiple lines and/or extensions.")
            }
        }
        Picker("Button Backlight Type", selection: $phone.baseKeyBacklightAmount) {
            Text("None").tag(0)
            Text("Numbers Only").tag(1)
            Text("Numbers + Some Function Buttons").tag(2)
            Text("Numbers + All Function Buttons").tag(2)
            Text("Numbers + Navigation Button").tag(3)
            Text("All Buttons").tag(3)
        }
        if phone.baseKeyBacklightAmount > 0 {
            ColorPicker("Button Backlight Color", selection: phone.baseKeyBacklightColorBinding)
            Picker("Button Backlight Layer", selection: $phone.baseKeyBacklightLayer) {
                Text("Background").tag(0)
                Text("Foreground").tag(1)
            }
            VStack {
                Text("Button Backlight Example")
                Image(systemName: phone.baseKeyBacklightLayer == 1 ? "5.square" : "5.square.fill")
                    .foregroundStyle(phone.baseKeyBacklightColorBinding.wrappedValue)
                    .font(.system(size: 40))
            }
        }
        ColorPicker("Button Foreground Color", selection: phone.baseKeyForegroundColorBinding)
        ColorPicker("Button Background Color", selection: phone.baseKeyBackgroundColorBinding)
        Button("Swap Foreground/Background Colors", systemImage: "arrow.swap") {
            phone.swapKeyBackgroundAndForegroundColors()
        }
    }
}

#Preview {
    Form {
        BaseDisplayBacklightButtonsView(phone: Phone(brand: "Uniden", model: "D3280"))
            .environmentObject(DialogManager())
    }
    .formStyle(.grouped)
}
