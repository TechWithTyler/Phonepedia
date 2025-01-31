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
        if phone.isCordless || phone.cordedPhoneType == 0 {
            Picker("Button Type", selection: $phone.buttonType) {
                Text("Spaced").tag(0)
                Text("Spaced with Click Feel").tag(1)
                Text("Some Spaced, Some Diamond-Cut").tag(2)
                Text("Some Spaced with Click Feel, Some Diamond-Cut").tag(3)
                Text("Diamond-Cut (No Space Between Buttons, Click Feel)").tag(4)
                Text("Touch Button Panel").tag(5)
            }
            if (!phone.isCordless && (phone.cordedPhoneType == 0 || phone.cordedPhoneType == 2)) || (phone.isCordless && phone.hasBaseSpeakerphone) {
                Toggle(isOn: $phone.hasBaseKeypad) {
                    Text(phone.isCordless ? "Has Base Keypad" : "Has User-Accessible Keypad")
                }
                InfoText("Some cordless phones have a base speakerphone and keypad, which allows you to make calls if the handset isn't nearby or if it needs to charge. Bases with keypads are a great option for office spaces as they combine a cordless-only phone with the design people expect from an office phone.\nSome corded phones, such as those found in hotel lobbies, don't have a user-accessible keypad and are used only for answering calls, checking voicemail, or calling a specific number when picking it up. The keypad and other programming controls are hidden behind a removable faceplate or within the phone's casing.")
                if phone.hasBaseKeypad {
                    Toggle(isOn: $phone.hasTalkingKeypad) {
                        Text("Talking Keypad")
                    }
                    InfoText("The phone can announce the keys you press when dialing numbers. Sometimes, this announcement plays instead of the DTMF tones (the tones heard when you dial numbers) on your end.")
                }
            }
        }
        if phone.hasBaseSpeakerphone && phone.isCordless && !phone.hasTransmitOnlyBase && !phone.hasCordedReceiver {
            Toggle("Dial On Base While Using Handset", isOn: $phone.dialWithBaseDuringHandsetCall)
            InfoText("During a call on a cordless handset, if the base isn't also on the call, you can use the base keypad to dial like on a corded phone.")
        }
        if (phone.hasBaseKeypad && phone.baseDisplayType == 0) || phone.cordedPhoneType == 2 {
            Toggle("7 Has Q and 9 Has Z", isOn: $phone.hasQZ)
            PhoneNumberLetterInfoView()
        }
        if phone.hasBaseKeypad || phone.hasAnsweringSystem == 1 || phone.hasAnsweringSystem == 3 {
            Toggle("Has Rotary Phone-Inspired Button Layout", isOn: $phone.hasRotaryInspiredButtonLayout)
            InfoText("Some phones have a rotary phone-inspired design, with the buttons arranged like a rotary dial. The display, if any, is located in the center of the \"dial\".")
        }
        if phone.isCordless || phone.cordedPhoneType == 0 {
            Picker(phone.isCordless ? "Display Type (Base)" : "Display Type", selection: $phone.baseDisplayType) {
                Text("None").tag(0)
                if phone.hasAnsweringSystem > 0 {
                    Text("LED Message Counter").tag(1)
                    Text("LCD Message Counter With Status Items").tag(2)
                }
                Text("Monochrome Display (Segmented)").tag(3)
                Text("Monochrome Display (Traditional)").tag(4)
                Text("Monochrome Display (Full-Dot with Status Items)").tag(5)
                Text("Monochrome Display (Full-Dot)").tag(6)
                Text("Color Display").tag(7)
                Text("Monochrome Touchscreen").tag(8)
                Text("Color Touchscreen").tag(9)
            }
            .onChange(of: phone.baseDisplayType) { oldValue, newValue in
                phone.baseDisplayTypeChanged(oldValue: oldValue, newValue: newValue)
            }
            if phone.baseDisplayType < 3 && !phone.isCordless {
                ProgrammingWithoutDisplayInfoView()
            }
            if phone.baseDisplayType >= 3 {
                Toggle("Base Display Can Tilt", isOn: $phone.baseDisplayCanTilt)
                Picker("Clock Display", selection: $phone.clock) {
                    Text("None").tag(0)
                    Text("Time Only").tag(1)
                    Text("Day and Time")
                    Text("Date and Time (w/o Year)").tag(3)
                    Text("Date and Time (w/ Year)").tag(4)
                }
            }
            InfoButton(title: "About Display Types…") {
                dialogManager.showingAboutDisplayTypes = true
            }
            if phone.baseDisplayType >= 5 && (phone.hasPhonebook || phone.hasCallerIDList || phone.callBlockCapacity > 0 || phone.baseRedialCapacity > 1) {
                Toggle("Allows Display of Multiple Entries", isOn: $phone.baseDisplayMultiEntries)
                MultiEntryDisplayInfoView()
            }
            if phone.isCordless && phone.baseDisplayType > 2 && (phone.basePhonebookCapacity > 0 || phone.baseCallerIDCapacity > 0 || phone.baseRedialCapacity > 0) {
                Picker("Base Menu Type", selection: $phone.cordlessBaseMenuType) {
                    Text("None").tag(0)
                    Text("Partial").tag(1)
                    Text("Full").tag(2)
                }
                InfoText("None: The base doesn't have a menu. The display is only used for lists and other information.\nPartial: The base has a menu, but it doesn't contain many of the options found in the handset menu, requiring use of the handset to change certain settings.\nFull: The base has a menu that contains most of the options found in the handset menu.")
            }
            if phone.cordlessBaseMenuType > 0 {
            Toggle("Menu Shows Multiple Items", isOn: $phone.baseMenuMultiItems)
                if phone.baseDisplayType >= 5 {
                    if phone.baseMenuMultiItems {
                        Picker("Main Menu Layout", selection: $phone.baseMainMenuLayout) {
                            Text("Single Item").tag(0)
                            Text("List").tag(1)
                            Text("Carousel").tag(2)
                            Text("Grid").tag(3)
                        }
                    }
                }
            }
            if phone.baseDisplayType > 2 && phone.baseDisplayType < 7 {
                ColorPicker("Base Display Backlight Color", selection: phone.baseDisplayBacklightColorBinding, supportsOpacity: false)
            }
            if phone.baseDisplayType >= 3 {
                Toggle("Base Has LED Message Counter In Addition To Display", isOn: $phone.baseHasDisplayAndMessageCounter)
            }
            if phone.baseDisplayType == 1 || phone.baseHasDisplayAndMessageCounter {
                ColorPicker("LED Message Counter Color", selection: phone.baseLEDMessageCounterColorBinding, supportsOpacity: false)
            }
            if phone.baseDisplayType > 2 {
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
                if phone.baseDisplayType > 3 {
                    Stepper("Base Soft Keys (Bottom): \(phone.baseSoftKeysBottom)", value: $phone.baseSoftKeysBottom, in: .zeroToMax(6))
                        .onChange(of: phone.baseSoftKeysBottom) { oldValue, newValue in
                            phone.baseSoftKeysBottomChanged(oldValue: oldValue, newValue: newValue)
                        }
                    Stepper("Base Soft Keys (Side): \(phone.baseSoftKeysSide) On Each Side (\(phone.baseSoftKeysSide * 2) total)", value: $phone.baseSoftKeysSide, in: .zeroToMax(5))
                        .onChange(of: phone.baseSoftKeysSide) { oldValue, newValue in
                            phone.baseSoftKeysSideChanged(oldValue: oldValue, newValue: newValue)
                        }
                    SoftKeyExplanationView()
                    InfoText("Side soft keys are often used for programmable functions or speed dials in standby or one-touch menu selections in menus. For example, in a menu with 5 options, instead of scrolling up or down through the menu and then pressing the select button, you can press the corresponding side soft key. Side soft keys are often seen on business-grade phones, especially those used on a system with multiple lines and/or extensions.")
                }
            }
        }
        if phone.isCordless || phone.cordedPhoneType == 0 || phone.cordedPhoneType == 2 {
            Picker("Button Lighting Type", selection: $phone.baseKeyBacklightAmount) {
                Text("None").tag(0)
                Text("Numbers Only").tag(1)
                Text("Numbers + Some Function Buttons").tag(2)
                Text("Numbers + All Function Buttons").tag(3)
                if phone.baseNavigatorKeyType > 0 {
                    Text("Numbers + Navigation Button").tag(4)
                    Text("All Buttons").tag(5)
                }
                if !phone.isCordless && phone.cordedPhoneType == 2 {
                    Text("Front Light").tag(6)
                }
            }
            if !phone.isCordless && phone.cordedPowerSource == 0 {
                InfoText("The brightness of a line-powered phone's button lighting depends on the line's off-hook voltage. If the phone's off-hook voltage is low, the backlight will be dim.")
            }
            if phone.baseKeyBacklightAmount > 0 {
                ColorPicker("Button Lighting Color", selection: phone.baseKeyBacklightColorBinding, supportsOpacity: false)
                if phone.baseKeyBacklightAmount < 6 {
                    Picker("Button Backlight Layer", selection: $phone.baseKeyBacklightLayer) {
                        Text("Background").tag(0)
                        Text("Foreground").tag(1)
                    }
                }
                VStack {
                    Text("Button Backlight Example")
                    Image(systemName: phone.baseKeyBacklightLayer == 1 ? "5.square" : "5.square.fill")
                        .foregroundStyle(phone.baseKeyBacklightColorBinding.wrappedValue)
                        .font(.system(size: 40))
                }
            }
            ColorPicker("Button Foreground Color", selection: phone.baseKeyForegroundColorBinding, supportsOpacity: false)
            ColorPicker("Button Background Color", selection: phone.baseKeyBackgroundColorBinding, supportsOpacity: false)
            Button("Swap Foreground/Background Colors", systemImage: "arrow.swap") {
                phone.swapKeyBackgroundAndForegroundColors()
            }
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
