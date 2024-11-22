//
//  HandsetDisplayBacklightButtonsView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 10/3/24.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct HandsetDisplayBacklightButtonsView: View {

    @Bindable var handset: CordlessHandset

    @EnvironmentObject var dialogManager: DialogManager

    var body: some View {
        if let phone = handset.phone {
            if handset.handsetStyle < 2 {
            Toggle("7 Has Q and 9 Has Z", isOn: handset.displayType == 0 ? $handset.hasQZ : .constant(true))
            PhoneNumberLetterInfoView()
                if handset.cordlessDeviceType == 0 {
                    Picker("Talk/Off Button Type", selection: $handset.talkOffButtonType) {
                        Text("Single Talk/Off Button").tag(0)
                        Text("Talk and Off").tag(1)
                        Text("Talk/Flash and Off").tag(2)
                        if handset.hasSpeakerphone {
                            Text("Talk/Speaker and Off").tag(3)
                        }
                        if phone.numberOfLandlines > 1 {
                            Text("Line Buttons + Off").tag(4)
                        }
                    }
                    InfoText("Sometimes, the talk button will have a function during a call, either switching between the earpiece and speakerphone or acting as the flash button.\nOn Bluetooth cell phone linking-capable models, if the cell button is a physical button and not a soft key, the talk button is often labeled \"Home\".\nOn multi-landline phones, the handset usually has multiple line buttons instead of a talk button.")
                }
                if handset.talkOffButtonType > 0 && handset.talkOffButtonType < 4 {
                    Picker("Talk/Off Button Coloring", selection: $handset.talkOffColorLayer) {
                        Text("None").tag(0)
                        Text("Foreground").tag(1)
                        Text("Background").tag(2)
                    }
                    InfoText("Foreground: The text/icon is colored.\nBackground: The button is filled with the color.")
                    PhoneButtonLegendItem(button: handset.hasPhysicalCellButton ? .home : .talk, colorLayer: handset.talkOffColorLayer)
                    PhoneButtonLegendItem(button: .off, colorLayer: handset.talkOffColorLayer)
                }
            }
            if handset.softKeys > 0 && (phone.numberOfLandlines > 1 || phone.baseBluetoothCellPhonesSupported > 0) {
                Picker("Line Buttons", selection: $handset.lineButtons) {
                    Text("Physical").tag(0)
                    Text("Soft Keys").tag(1)
                }
                InfoText("A handset with soft keys for the line buttons can easily adapt to bases with different numbers of lines. For example, the same handset can be supplied and used with both the cell phone linking and non-cell phone linking models of a series.\nHandsets with physical line buttons may be programmed to expect all of its lines to be supported, potentially causing compatibility issues on bases without those lines.")
            }
            if handset.lineButtons == 0 && phone.baseBluetoothCellPhonesSupported > 0 {
                PhoneButtonLegendItem(button: .cell, colorLayer: 1)
            }
            Picker("Button Type", selection: $handset.buttonType) {
                Text("Spaced").tag(0)
                Text("Spaced with Click Feel").tag(1)
                Text("Some Spaced, Some Diamond-Cut").tag(2)
                Text("Some Spaced with Click Feel, Some Diamond-Cut").tag(3)
                Text("Diamond-Cut (No Space Between Buttons, Click Feel)").tag(4)
            }
            Toggle(isOn: $handset.hasTalkingKeypad) {
                Text("Talking Keypad")
            }
            Picker("Display Type", selection: $handset.displayType) {
                if handset.handsetStyle < 2 {
                    Text("None").tag(0)
                    Text("Monochrome (Segmented)").tag(1)
                    Text("Monochrome (Traditional)").tag(2)
                    Text("Monochrome (Full-Dot With Status Items)").tag(3)
                }
                Text("Monochrome (Full-Dot)").tag(4)
                Text("Color").tag(5)
            }
            .onChange(of: handset.displayType) { oldValue, newValue in
                handset.displayTypeChanged(oldValue: oldValue, newValue: newValue)
            }
            InfoButton(title: "About Display Types…") {
                dialogManager.showingAboutDisplayTypes = true
            }
            if handset.displayType >= 3 {
                Picker("Main Menu Layout", selection: $handset.mainMenuLayout) {
                    Text("List").tag(0)
                    Text("Carousel").tag(2)
                    Text("Grid").tag(3)
                }
            }
            if handset.displayType > 0 && handset.displayType < 5 {
                ColorPicker("Display Backlight Color", selection: handset.displayBacklightColorBinding)
            }
            if handset.displayType > 0 {
                Picker("Update Available Handset Menus", selection: $handset.menuUpdateMode) {
                    Text("Based on Registered Base").tag(0)
                    Text("In Real-Time").tag(1)
                }
                InfoText("When a handset menu is updated based on the base it's registered to, the available options are updated only when registering the handset to a base, and those same options will be available when the handset boots up. When a handset menu is updated in real-time, the available options depend on the state of the registered base (e.g. whether it's on power backup or if there's enough devices to support intercom), and some options might not be available when the handset boots up.")
                if handset.handsetStyle < 2 {
                    Picker("Navigation Button Type", selection: $handset.navigatorKeyType) {
                        Text("None").tag(0)
                        Text("Up/Down Button").tag(1)
                        Text("Up/Down/Left/Right Button").tag(2)
                        Text("Up/Down/Left/Right Joystick").tag(3)
                        Text("Up/Down Side Buttons, Left/Right Face Buttons").tag(4)
                    }
                    .onChange(of: handset.navigatorKeyType) { oldValue, newValue in
                        handset.navigatorKeyTypeChanged(oldValue: oldValue, newValue: newValue)
                    }
                }
                if handset.navigatorKeyType > 0 {
                    Picker("Navigation Button Center Button", selection: $handset.navigatorKeyCenterButton) {
                        Text("None").tag(0)
                        Text("Select").tag(1)
                        Text("Menu/Select").tag(2)
                        if handset.softKeys == 3 {
                            Text("Middle Soft Key").tag(3)
                        }
                        Text("Other Function").tag(4)
                    }
                    if handset.sideVolumeButtons {
                        Toggle("Navigation Button Up/Down for Volume", isOn: $handset.navigatorKeyUpDownVolume)
                    }
                    Toggle("Navigation Button Standby Shortcuts", isOn: $handset.navigatorKeyStandbyShortcuts)
                }
                if handset.displayType > 1 {
                    Stepper("Soft Keys: \(handset.softKeys)", value: $handset.softKeys, in: 0...3)
                        .onChange(of: handset.softKeys) { oldValue, newValue in
                            handset.softKeysChanged(oldValue: oldValue, newValue: newValue)
                        }
                    SoftKeyExplanationView()
                    Toggle("Standby Soft Keys Customizable", isOn: $handset.standbySoftKeysCustomizable)
                    InfoText("Some handsets offer the ability to customize the soft key functions that are available in standby.")
                }
            }
            if handset.navigatorKeyType != 4 {
                Toggle("Has Dedicated/Side Volume Buttons", isOn: $handset.sideVolumeButtons)
                    .onChange(of: handset.sideVolumeButtons) { oldValue, newValue in
                        handset.sideVolumeButtonsChanged(oldValue: oldValue, newValue: newValue)
                    }
            }
            Picker("Button Backlight Type", selection: $handset.keyBacklightAmount) {
                Text("None").tag(0)
                Text("Numbers Only").tag(1)
                Text("Numbers + Some Function Buttons").tag(2)
                Text("Numbers + All Function Buttons").tag(2)
                Text("Numbers + Navigation Button").tag(3)
                Text("All Buttons").tag(3)
            }
            if handset.keyBacklightAmount > 0 {
                ColorPicker("Button Backlight Color", selection: handset.keyBacklightColorBinding)
                Picker("Button Backlight Layer", selection: $handset.keyBacklightLayer) {
                    Text("Background").tag(0)
                    Text("Foreground").tag(1)
                }
                VStack {
                    Text("Key Backlight Example")
                    Image(systemName: handset.keyBacklightLayer == 1 ? "5.square" : "5.square.fill")
                        .foregroundStyle(handset.keyBacklightColorBinding.wrappedValue)
                        .font(.system(size: 40))
                }
            }
            ColorPicker("Button Foreground Color", selection: handset.keyForegroundColorBinding)
            ColorPicker("Button Background Color", selection: handset.keyBackgroundColorBinding)
            Button("Swap Foreground/Background Colors", systemImage: "arrow.swap") {
                handset.swapKeyBackgroundAndForegroundColors()
            }
        } else {
            Text("Error")
        }
    }
}

#Preview {
    Form {
        HandsetDisplayBacklightButtonsView(handset: CordlessHandset(brand: "Panasonic", model: "KX-TGFA61", mainColorRed: 0, mainColorGreen: 0, mainColorBlue: 0, secondaryColorRed: 200, secondaryColorGreen: 200, secondaryColorBlue: 200))
            .environmentObject(DialogManager())
    }
    .formStyle(.grouped)
}
