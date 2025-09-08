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
            Section("Buttons") {
                if handset.cordlessDeviceType < 2 {
                    Picker("Button Behavior While Charging", selection: $handset.buttonPressOnChargeBehavior) {
                            Text("Locked").tag(0)
                            Text("Prompt to Pick Up").tag(1)
                            Text("Normal").tag(2)
                        }
                    InfoText("• Locked: Button presses are ignored while the handset is on charge.\n• Prompt to Pick Up: Pressing any button while the handset is on charge prompts you to pick it up.\n• Normal: You can use the handset as normal while it's on charge. This is useful if you're trying to configure it but the battery is too low to use off charge.")
                    Toggle("Has Keypad Lock", isOn: $handset.hasKeypadLock)
                    KeypadLockInfoView()
                }
                if handset.handsetStyle < 2 {
                    if handset.displayType == 0 {
                        Toggle("7 Has Q and 9 Has Z", isOn: $handset.hasQZ)
                    }
                    PhoneNumberLetterInfoView()
                    if handset.cordlessDeviceType == 0 {
                        Picker("Talk/Off Button Type", selection: $handset.talkOffButtonType) {
                            Text("Single Talk/Off Button/Switch").tag(0)
                            Text("Talk and Off").tag(1)
                            Text("Talk/Flash and Off").tag(2)
                            if handset.hasSpeakerphone {
                                Text("Talk/Speaker and Off").tag(3)
                            }
                            if phone.isMultiline {
                                Text("Line Buttons + Off").tag(4)
                            }
                        }
                        InfoText("On some handsets, the talk button has a secondary function during a call, either switching between the earpiece and speakerphone or acting as the flash button.\nOn Bluetooth cell phone linking-capable models, if the cell button is a physical button and not a soft key, the talk button is often labeled \"Home\".\nOn multi-landline phones, the handset usually has multiple line buttons instead of a talk button.")
                    }
                    if handset.hasTalkButton {
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

                if handset.softKeys > 0 && handset.talkOffButtonType != 4 && (phone.isMultiline || phone.baseBluetoothCellPhonesSupported > 0) {
                    Picker("Line Buttons", selection: $handset.lineButtons) {
                        Text("Physical").tag(0)
                        Text("Soft Keys").tag(1)
                    }
                    InfoText("A handset with soft keys for the line buttons can easily adapt to bases with different numbers of lines. For example, the same handset can be supplied and used with both the cell phone linking and non-cell phone linking models of a series.\nHandsets with physical line buttons may be programmed to expect all of its lines to be supported, potentially causing compatibility issues on bases without those lines.")
                }
                if handset.hasPhysicalCellButton {
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
                Picker("Button Backlight", selection: $handset.keyBacklightAmount) {
                    Text("None").tag(0)
                    Text("Numbers Only").tag(1)
                    Text("Numbers + Some Function Buttons").tag(2)
                    Text("Numbers + All Function Buttons").tag(3)
                    Text("Numbers + Navigation Button").tag(4)
                    Text("All Buttons").tag(5)
                }
                if handset.keyBacklightAmount > 0 {
                    ColorPicker("Button Backlight Color", selection: handset.keyBacklightColorBinding, supportsOpacity: false)
                    Picker("Button Backlight Layer", selection: $handset.keyBacklightLayer) {
                        Text("Background").tag(0)
                        Text("Foreground").tag(1)
                    }
                    VStack {
                        Text("Button Backlight Example")
                        Image(systemName: "5.square.fill")
                            .foregroundStyle(
                                handset.keyBacklightLayer == 0 ? handset.keyForegroundColorBinding.wrappedValue : handset.keyBacklightColorBinding.wrappedValue,
                                handset.keyBacklightLayer == 0 ? handset.keyBacklightColorBinding.wrappedValue : handset.keyBackgroundColorBinding.wrappedValue
                            )
                            .font(.system(size: 40))
                    }
                }
                if handset.keyBacklightAmount == 0 || handset.keyBacklightLayer == 0 {
                    ColorPicker("Button Foreground Color", selection: handset.keyForegroundColorBinding, supportsOpacity: false)
                }
                if handset.keyBacklightAmount == 0 || handset.keyBacklightLayer == 1 {
                    ColorPicker("Button Background Color", selection: handset.keyBackgroundColorBinding, supportsOpacity: false)
                }
                if handset.keyBacklightAmount == 0 {
                    Button("Swap Foreground/Background Colors", systemImage: "arrow.swap") {
                        handset.swapKeyBackgroundAndForegroundColors()
                    }
                }
            }
            Section("Display") {
                Picker("Display Type", selection: $handset.displayType) {
                    if handset.handsetStyle < 2 {
                        Text("None").tag(0)
                        Text("Monochrome (Segmented)").tag(1)
                        Text("Monochrome (Traditional)").tag(2)
                        Text("Monochrome (Full-Dot w/ Status Items)").tag(3)
                    }
                    Text("Monochrome (Full-Dot)").tag(4)
                    Text("Color").tag(5)
                }
                .onChange(of: handset.displayType) { oldValue, newValue in
                    handset.displayTypeChanged(oldValue: oldValue, newValue: newValue)
                }
                if handset.displayType == 0 {
                    ProgrammingWithoutDisplayInfoView()
                    if phone.hasAnsweringSystem > 1 {
                        InfoText("Answering system settings are typically changed from the handset by pressing the program button followed by the message playback button, then entering codes on the keypad. The current settings may be displayed on the base message counter or display (if it has one), in which case the handset will link to the base after entering answering system programming mode or the desired setting code is entered.\nFor example, the remote access code might be changed by pressing the program button > the message playback button > 2 for remote access code > the desired code > the program or message playback button again to save.")
                    }
                } else {
                    Picker("Base-Specific Settings On Handset", selection: $handset.baseSettingsChangeMethod) {
                        Text("None").tag(0)
                        Text("Base Settings Menu").tag(1)
                        Text("Handset/Base Selection").tag(2)
                    }
                    InfoText("Some phones allow you to change base-specific settings, such as the ringer volume, from the handset.\n•None: No base-specific settings can be changed from this handset/all base-specific settings can only be changed from the base.\n• Base Settings Menu: All base-specific settings are contained in a dedicated handset menu. This may be a top-level menu or found in the settings menu.\n• Handset/Base Selection: When selecting a setting in the menu and the base also has a corresponding setting, the handset can prompt you to select Handset or Base.\nSeparate handset/base settings menus example: HS Settings > Ringer Settings > Ringer Volume for the handset and Base Settings > Ringer Settings > Ringer Volume for the base.\nHandset/base selection example: Settings > Ringer Settings > Ringer Volume > Handset or Base.")
                }
                if handset.isDesksetWithDisplay {
                    Toggle("Display Can Tilt", isOn: $handset.desksetDisplayCanTilt)
                }
                if handset.displayType > 1 && (handset.handsetStyle < 2 || handset.cordlessDeviceType == 1) {
                    Picker("Clock Display", selection: $handset.clock) {
                        Text("None").tag(0)
                        Text("Time Only").tag(1)
                        Text("Day and Time").tag(2)
                        Text("Date and Time (w/o Year)").tag(3)
                        Text("Date and Time (w/ Year)").tag(4)
                    }
                    if handset.clock > 0 {
                        Toggle("Supports Clock Backup", isOn: $handset.supportsTimeBackup)
                        InfoText("On a handset/deskset which displays a clock, clock backup allows it to store the clock settings for as long as it has power. This allows it to restore them to the base when power returns, since most bases don't preserve them when they lose power.")
                    }
                }
                InfoButton(title: "About Display Types…") {
                    dialogManager.showingAboutDisplayTypes = true
                }
                if handset.displayType >= 3 && handset.handsetStyle < 2 && handset.hasListsOfEntries {
                    Toggle("Allows Display of Multiple Entries", isOn: $handset.displayMultiEntries)
                    MultiEntryDisplayInfoView()
                }
                if handset.displayType >= 2 && handset.handsetStyle < 2 {
                    Toggle("Menu Shows Multiple Items", isOn: $handset.menuMultiItems)
                    if handset.displayType >= 3 {
                        if handset.menuMultiItems {
                            Picker("Main Menu Layout", selection: $handset.mainMenuLayout) {
                                Text("Single Item").tag(0)
                                Text("List").tag(1)
                                Text("Carousel").tag(2)
                                Text("Grid").tag(3)
                            }
                        }
                    }
                }
                if handset.hasMonochromeDisplay {
                    ColorPicker("Display Backlight Color", selection: handset.displayBacklightColorBinding, supportsOpacity: false)
                }
                if handset.displayType > 0 {
                    Picker("Update Available Handset Menus", selection: $handset.menuUpdateMode) {
                        Text("Based on Registered Base").tag(0)
                        Text("In Real-Time").tag(1)
                    }
                    InfoText("When a handset menu is updated based on the base it's registered to, the available options are updated only when registering the handset to a base, and those same options will be available when the handset boots up. When a handset menu is updated in real-time, the available options depend on the state of the registered base (e.g. whether it's on place-on-base power backup or if there's enough devices to support intercom), and some options might not be available when the handset boots up.")
                }
            }
            Section("Navigation Button/Soft Keys") {
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
                    if handset.navigatorKeyCenterButton == 3 {
                        InfoText("The handset has 2 soft keys (left and right) below the display, with the navigation button's center button being used as the middle soft key instead of the middle soft key being in-between the left and right soft keys.")
                    }
                    if handset.navigatorKeyType > 0 && handset.navigatorKeyType < 4 {
                        VStack(alignment: .center) {
                            Text("Navigation Button Example")
                            ZStack {
                                Circle()
                                    .fill(Color.secondary.opacity(0.15))
                                    .frame(width: 100, height: 100)
                                VStack(spacing: 20) {
                                    Image(systemName: "arrowtriangle.up.fill")
                                        .accessibilityLabel("Up")
                                    HStack(alignment: .center, spacing: 20) {
                                        if handset.navigatorKeyType == 3 {
                                            Image(systemName: "arrowtriangle.left.fill")
                                                .accessibilityLabel("Left")
                                        }
                                        if handset.navigatorKeyCenterButton > 0 {
                                            Image(systemName: "circle.fill")
                                                .font(.system(size: 18))
                                                .accessibilityLabel("Center Button")
                                        }
                                        if handset.navigatorKeyType == 3 {
                                            Image(systemName: "arrowtriangle.right.fill")
                                                .accessibilityLabel("Right")
                                        }
                                    }
                                    Image(systemName: "arrowtriangle.down.fill")
                                        .accessibilityLabel("Down")
                                }
                                .font(.system(size: 18))
                                .foregroundStyle(Color.primary)
                            }
                        }
                    }
                    if handset.sideVolumeButtons {
                        Toggle("Navigation Button Up/Down for Volume", isOn: $handset.navigatorKeyUpDownVolume)
                    }
                    Toggle("Navigation Button Standby Shortcuts", isOn: $handset.navigatorKeyStandbyShortcuts)
                }
                if handset.displayType > 1 {
                    Stepper("Soft Keys: \(handset.softKeys)", value: $handset.softKeys, in: .zeroToMax(3))
                        .onChange(of: handset.softKeys) { oldValue, newValue in
                            handset.softKeysChanged(oldValue: oldValue, newValue: newValue)
                        }
                    SoftKeyExplanationView()
                    Toggle("Standby Soft Keys Customizable", isOn: $handset.standbySoftKeysCustomizable)
                    InfoText("Some handsets offer the ability to customize the soft key functions that are available in standby.")
                }
                if handset.navigatorKeyType != 4 {
                    Toggle("Has Dedicated/Side Volume Buttons", isOn: $handset.sideVolumeButtons)
                        .onChange(of: handset.sideVolumeButtons) { oldValue, newValue in
                            handset.sideVolumeButtonsChanged(oldValue: oldValue, newValue: newValue)
                        }
                }
            }
        } else {
            Text("Error")
        }
    }
}

#Preview {
    Form {
        HandsetDisplayBacklightButtonsView(handset: CordlessHandset(brand: "Panasonic", model: "KX-TGFA61", mainColorRed: 0, mainColorGreen: 0, mainColorBlue: 0, secondaryColorRed: 0, secondaryColorGreen: 0, secondaryColorBlue: 0, accentColorRed: 200, accentColorGreen: 200, accentColorBlue: 200))
            .environmentObject(DialogManager())
    }
    .formStyle(.grouped)
}
