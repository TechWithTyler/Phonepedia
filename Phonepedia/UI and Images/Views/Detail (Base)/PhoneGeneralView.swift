//
//  PhoneGeneralView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 10/3/24.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct PhoneGeneralView: View {

    // MARK: - Properties - Objects

    @EnvironmentObject var dialogManager: DialogManager

    @Bindable var phone: Phone

    // MARK: - Properties - Strings

    var cordedCordlessSectionName: String {
        if phone.isCordedCordless {
            return "Corded/Cordless Phone"
        } else if phone.isCordless {
            return "Cordless Phone"
        } else if phone.isWiFiHandset {
            return "Wi-Fi Handset"
        } else {
            return "Corded Phone"
        }
    }

    // MARK: - Properties - Booleans

    @AppStorage(UserDefaults.KeyNames.phoneDescriptionTextSize) var phoneDescriptionTextSize: Double = SATextViewMinFontSize

    // MARK: - Body

    var body: some View {
        Section("Basic Info") {
            Stepper("Release Year (-1 If Unknown): \(String(phone.releaseYear))", value: $phone.releaseYear, in: -1...currentYear)
                .onChange(of: phone.releaseYear) { oldValue, newValue in
                    phone.releaseYearChanged(oldValue: oldValue, newValue: newValue)
                }
            FormTextField("Nickname", text: $phone.nickname)
            Stepper("Acquisition/Purchase Year (-1 If Unknown): \(String(phone.acquisitionYear))", value: $phone.acquisitionYear, in: -1...currentYear)
                .onChange(of: phone.acquisitionYear) { oldValue, newValue in
                    phone.acquisitionYearChanged(oldValue: oldValue, newValue: newValue)
                }
            if phone.acquiredInYearOfRelease {
                HStack {
                    Image(systemName: "sparkle")
                    Text("You got the \(String(phone.releaseYear)) \(phone.brand) \(phone.model) the year it was released!")
                        .font(.callout)
                }
            }
            Picker("How I Got This Phone", selection: $phone.whereAcquired) {
                AcquisitionMethodPickerItems()
            }
            Picker("Place In My Collection", selection: $phone.storageOrSetup) {
                PhoneInCollectionStatusPickerItems()
            }
            if phone.landlineConnectionType != 4 && !phone.isWiFiHandset && !phone.isBusinessCordedCordlessSystem {
                Picker("Grade", selection: $phone.grade) {
                    Text("1 - Residential/Small Business").tag(0)
                    Text("2 - Hotel").tag(2)
                    Text("3 - Large Business").tag(1)
                }
                InfoButton(title: "About Phone Grades…") {
                    dialogManager.showingAboutPhoneGrades = true
                }
            }
            Toggle("Needed One or More Non-Accessory Replacements", isOn: $phone.neededReplacements)
            InfoText("Sometimes, one or more parts of your phones may break or come broken and can't be fixed easily (e.g. broken base/handset speaker or display, corrupt memory on a base or handset that a factory reset can't fix, handsets unable to register/link to the base).\nYou can replace handsets easily just as you would purchase additional handsets, but you might end up with more parts than what you needed (e.g. you needed just a handset but also got a charger). To replace just a base or charger, you'll need to look on the used market or purchase an entire new phone set.\nIf you don't want to replace broken parts, you can try to send them to someone who can repair them, or if you know how to, repair it yourself.")
            VStack {
                Text("Write more about your phone (e.g., the story behind why you got it, when/where you got it, whether you had to replace broken parts) in the text area below.\nExample: \"\(phoneDescriptionSampleText)\"")
                    .lineLimit(nil)
                Stepper("Font Size: \(Int(phoneDescriptionTextSize))", value: $phoneDescriptionTextSize)
                ContrastingTextEditor(text: $phone.phoneDescription)
                    .frame(minHeight: 300)
                    .padding()
                    .font(.system(size: phoneDescriptionTextSize))
            }
            Stepper("Number of Included Cordless Devices (0 If Not Cordless): \(phone.numberOfIncludedCordlessHandsets)", value: $phone.numberOfIncludedCordlessHandsets, in: .zeroToMax(15))
                .disabled(phone.handsetNumberDigit != nil)
                .onChange(of: phone.numberOfIncludedCordlessHandsets) { oldValue, newValue in
                    phone.numberOfIncludedCordlessHandsetsChanged(oldValue: oldValue, newValue: newValue)
                }
                .onChange(of: phone.isCordless) { oldValue, newValue in
                    if !newValue && (!phone.cordlessHandsetsIHave.isEmpty || !phone.chargersIHave.isEmpty) {
                        dialogManager.showingMakeCordedOnly = true
                        phone.numberOfIncludedCordlessHandsets = 1
                        return
                    }
                    phone.isCordlessChanged(oldValue: oldValue, newValue: newValue)
                }
                .alert("Specifying that this phone comes with 0 cordless devices makes it a non-cordless phone. Continue?", isPresented: $dialogManager.showingMakeCordedOnly) {
                    Button("OK") {
                        phone.cordlessHandsetsIHave.removeAll()
                        phone.chargersIHave.removeAll()
                        phone.numberOfIncludedCordlessHandsets = 0
                        dialogManager.showingMakeCordedOnly = false
                    }
                    Button("Cancel", role: .cancel) {
                        dialogManager.showingMakeCordedOnly = false
                    }
                } message: {
                    Text("This will delete all cordless devices (\(phone.cordlessHandsetsIHave.count)) and chargers \(phone.chargersIHave.count)!")
                }
            if !phone.isCordless {
                Toggle("Is Wi-Fi Handset", isOn: $phone.isWiFiHandset)
            }
        }
        Section(cordedCordlessSectionName) {
            if !phone.isWiFiHandset {
                if phone.isCordless {
                    Group {
                        HandsetNumberDigitView(phone: phone)
                        if phone.isDigitalCordless {
                            Stepper("Maximum Number of Cordless Devices (-1 If No Limit): \(phone.maxCordlessHandsets)", value: $phone.maxCordlessHandsets, in: -1...15)
                                .onChange(of: phone.maxCordlessHandsets) { oldValue, newValue in
                                    phone.maxCordlessHandsetsChanged(oldValue: oldValue, newValue: newValue)
                                }
                            InfoText("If the phone uses the \"security codes must match\" method where the base doesn't know or care how many cordless handsets are being used with it, set this to -1. Press the button below to learn more about the differences between registration and \"security codes must match\".")
                        }
                        InfoButton(title: "Registration/Security Code Explanation…") {
                            dialogManager.showingRegistrationExplanation = true
                        }
                    }
                    Picker("Frequency", selection: $phone.frequency) {
                        ForEach(Phone.CordlessFrequency.allCases) { frequency in
                            if frequency.rawValue < 0 {
                                Divider()
                            } else {
                                Text(frequency.name).tag(frequency)
                            }
                        }
                    }
                    .onChange(of: phone.isDigitalCordless) { oldValue, newValue in
                        phone.isDigitalCordlessChanged(oldValue: oldValue, newValue: newValue)
                    }
                    if phone.frequency == 0 {
                        WarningText("You may not be able to specify certain features/aspects of this phone without knowing its frequency! Try looking up the wireless frequency and communication technology (whether it's analog or digital) of the \(phone.brand) \(phone.model) and select the correct option above.")
                    }
                    InfoButton(title: "Frequencies/Communication Technologies Explanation…") {
                        dialogManager.showingFrequenciesExplanation = true
                    }
                    if phone.isDigitalCordless {
                        Toggle("Supports Range Extenders", isOn: $phone.supportsRangeExtenders)
                        InfoText("A range extender, also known as a repeater, extends the range (or \"repeats the signal\") of the base it's registered to. Devices communicating with the base choose the base or a range extender based on which has the strongest signal, just like devices connected to a mesh Wi-Fi network.\nIf you register 2 or more range extenders, they can be \"daisy-chained\" (one can communicate with the base via another) to create a larger useable coverage area.\nWhen a cordless device moves between the base or range extender(s), your call may briefly cut out.\nIf a handset is communicating with a range extender and that range extender loses power or its link to the base, the handset will also lose its link to the base for a few seconds, which will cause the handset to either connect to the base or another range extender, or drop the call entirely.")
                        Toggle("Briefly Holds Ongoing Call When Out Of Range", isOn: $phone.holdForOutOfRange)
                        InfoText("Typically, with digital cordless phones, when a handset moves out of range from the base during a call, the call is dropped. With some cordless phones, the base can put the call on hold for a short time once it detects that the handset has gone out of range, to allow the call to continue if the handset moves back in range quickly enough. On analog cordless phones, the base can't know that the handset went out of range, so the phone will remain off-hook until the base is unplugged and plugged back in, or the handset goes back in range without having been hung up first (or for some single-handset models, placing a handset on the base).")
                        Picker("ECO Mode", selection: $phone.ecoMode) {
                            Text("Not Supported").tag(0)
                            Text("Reduced Power Only").tag(1)
                            Text("Reduced Power or No Transmit").tag(2)
                        }
                        InfoText("ECO mode allows transmission power to be reduced to save energy, either for cordless devices that are close to or placed on the base, or for the entire system by manual activation.\nSome phones can stop all transmission when in standby mode. The handset distinguishes between \"base not transmitting\" and \"out of range\" by occasionally sending a signal to the base to wake it up. A wake-up signal is also sent when the handset is picked up from charge or when any button is pressed. If the handset fails to receive an acknowledgment from the base, the handset is considered out of range. Since the handset needs to check for the base more frequently in \"no transmit\" mode, the phone will still occasionally transmit in standby mode and the handset battery life may be reduced.")
                    }
                    Picker("Antenna(s)", selection: $phone.antennas) {
                        Text("Hidden").tag(0)
                        Text("Telescopic").tag(1)
                        Text("Standard (Left)").tag(2)
                        Text("Standard (Right)").tag(3)
                        Text("One On Each Side").tag(4)
                    }
                    AntennaInfoView()
                    if !phone.isCordedCordless {
                        Toggle("Base Is Transmit-Only", isOn: $phone.hasTransmitOnlyBase)
                            .onChange(of: phone.hasTransmitOnlyBase) { oldValue, newValue in
                                phone.transmitOnlyBaseChanged(oldValue: oldValue, newValue: newValue)
                            }
                        Picker("Wall Mounting", selection: $phone.wallMountability) {
                            Text("Not Supported").tag(0)
                            Text("Holes on Back").tag(1)
                            Text("Optional Bracket").tag(2)
                            Text("Built-In Bracket").tag(3)
                            Text("Desk/Wall Bracket").tag(4)
                        }
                        if !phone.hasBaseKeypad && !phone.hasTransmitOnlyBase {
                            Toggle("Has Charger-Style Base", isOn: $phone.hasChargerSizeBase)
                            InfoText("Some cordless phone bases look similar to/have a similar size to chargers. In some cases, such as when the base has no answering system controls, they can be easily mistaken for chargers, although a base is always slightly bigger than a charger.\nThese kinds of bases are ideal for those who want a small-footprint base. The differentiating factor between a charger-style base vs a standard base is that the handset charging area is in the same horizontal position as that of the charger (usually the center).\nTip: The main base has at least a phone jack or handset locator button. Chargers just plug into power.")
                        }
                    }
                    if phone.baseChargesHandset {
                        Toggle("Has Charge Light", isOn: $phone.hasChargeLight)
                        if phone.hasChargeLight {
                            ColorPicker("Charge Light Color (Charging)", selection: phone.chargeLightColorChargingBinding, supportsOpacity: false)
                            ClearSupportedColorPicker("Charge Light Color (Charged)", selection: phone.chargeLightColorChargedBinding) {
                                Text("Off When Charged")
                            }
                            Button("Use Charging Color") {
                                phone.setChargeLightChargedColorToCharging()
                            }
                        }
                        Group {
                            Picker("Base Charging Direction", selection: $phone.baseChargingDirection) {
                                ChargingDirectionPickerItems()
                            }
                            InfoText("Variations in charging area designs are one of the many ways cordless phones look different from one another.\n\"Lean Back\" means the handset leans back in the charging area but isn't fully flat (\"Lay Down\").\nA reversible handset can charge with the keypad facing either up or down. While there's no benefit to this design with phones without handset displays, the phone may still have this design if the base or handset casing is shared with a model that has a handset display.")
                            if phone.baseChargingDirection == 6 {
                                InfoText("This charging area design is often seen on phones where the base sits flush with the wall when wall-mounted. When wall-mounted, the face-down lay down position is the only way the handset can charge securely.")
                            }
                            if phone.wallMountability > 0 && phone.hasLayDownCharging {
                                Picker("Lay-Down Hook Type", selection: $phone.cordlessHandsetLayDownHookType) {
                                    Text("None").tag(0)
                                    Text("Fixed").tag(1)
                                    Text("Flip/Rotate (Face/Back)").tag(2)
                                    Text("Flip (Top)").tag(3)
                                }
                                InfoText("• None: The handset doesn't need an extra hook to stay in place while the base is wall-mounted.\n• Fixed: The base has a hook that slots into a hole on the handset.\n• Flip/Rotate (Face/Back): The base has a hook that can be flipped or rotated so it sticks out when you want to mount the base on the wall, or so it doesn't stick out when you don't want to mount it on the wall.\n• Flip (Top): The hook is located at the top of the charging area and needs to be flipped down to hold the handset in place while the base is wall-mounted, and flipped back up to take the handset off the base.")
                            }
                            Picker("Base Charge Contact Placement", selection: $phone.baseChargeContactPlacement) {
                                ChargeContactPlacementPickerItems()
                            }
                            Picker("Base Charge Contact Type", selection: $phone.baseChargeContactType) {
                                ChargeContactTypePickerItems()
                            }
                            ChargingContactInfoView()
                            Toggle("Base Has Separate Data Contact", isOn: $phone.baseHasSeparateDataContact)
                            InfoText("""
Most modern cordless phones pass data through the 2 charging contacts for various features including the following. However, many older cordless phones, especially 46-49MHz and 900MHz models, used a separate, 3rd contact for data.
• Detecting the handset being placed on the base for registration.
• Detecting the handset being lifted off the base to switch from the base speakerphone to the handset.
In most cases, if the base has a charge light/display message, the completion of the charge circuit turns it on, but sometimes that's handled by the separate data contact if the phone has one.
""")
                        }
                    }
                    if phone.isDigitalCordless && phone.maxCordlessHandsets > 1 {
                        if phone.hasBaseIntercom {
                            Picker("Handset Locator Button(s)", selection: $phone.locatorButtons) {
                                Text(phone.hasBaseKeypad && phone.handsetLocatorUsesIntercom ? "One for All HS/Keypad Entry" : "One For All Handsets").tag(0)
                                Text("One for Each Handset").tag(1)
                                Text("Each HS + All").tag(2)
                                Text("Select + Call Buttons").tag(3)
                            }
                            .onChange(of: phone.locatorButtons) { oldValue, newValue in
                                phone.locatorButtonsChanged(oldValue: oldValue, newValue: newValue)
                            }
                            InfoText("Handset locator allows you to locate (page) the handset(s) so you can find them. The term \"page\" comes from the fact that this makes the handset beep or ring, just like how pagers beep when they're called.\n• One for All: A single locator button pages or makes an intercom call to all handsets. If the base has a keypad, you can call all handsets or a specific one.\n• One for Each: The base has one locator button for each handset slot. For example, a phone that only expands up to 3 handsets would have 3 handset locator buttons, one for each of the 3 handsets.\nEach HS + All: The base has one locator button for each handset slot, as well as a button to page all handsets.\nSelect + Call Buttons: Press the select button to select the desired handset, then press the call button to call it. This is often seen on phones where the base's physical design is shared between a 2-handset model and a 3-or-more-handset model.")
                            if phone.locatorButtons == 0 {
                                Toggle("Handset Locator Uses Intercom", isOn: $phone.handsetLocatorUsesIntercom)
                            }
                            InfoText("Some phones use intercom as the means of locating handsets, even if the base doesn't have intercom. This means that the handset locator and intercom from the base are the same feature, and therefore, the handset may indicate \"call from base\" instead of \"paging\".")
                        }
                        if !phone.isCordedCordless && !phone.hasTransmitOnlyBase && phone.deregistration > 0 && phone.locatorButtons == 0 {
                            Toggle("Place-On-Base Auto-Register", isOn: $phone.placeOnBaseAutoRegister)
                            InfoText("The base can detect an unregistered handset being placed on it, which will put it into registration mode. Aside from putting the base into registration mode, data isn't exchanged through the contacts like it is on phones using the \"place handset on base to set digital security code\" method. Manually putting the base in registration mode is still available for re-registering handsets or for registering handsets which don't fit on the base.")
                            if phone.placeOnBaseAutoRegister && phone.noFittingHandsets {
                                WarningText("This feature can't be used since you don't have any handsets which fit on the base!")
                            }
                        }
                        Picker("Deregistration", selection: $phone.deregistration) {
                            if phone.locatorButtons > 0 {
                                Text("Not Supported").tag(0)
                            }
                            Text("From This Handset").tag(1)
                            Text("One From Any Handset/Base").tag(2)
                            Text("Multiple From Any Handset/Base").tag(3)
                            Text("All From Base").tag(4)
                        }
                        .onChange(of: phone.deregistration) { oldValue, newValue in
                            phone.deregistrationChanged(oldValue: oldValue, newValue: newValue)
                        }
                        InfoText("Deregistration allows the base and handset to delete their registration information, allowing you to make room for new handsets and/or to use a handset on a different base.\n• Not Supported: Handsets can't be deregistered. Depending on the phone, you may be able to register a handset over an unwanted slot, then back to the desired slot, to \"deregister\" the unwanted one.\n • From This Handset: Deregistration can only be done from the handset you want to deregister. The base may have the ability to \"forget\" a handset if it's not available.\n• One From Any Handset/Base: Deregistration can be done from any handset or the base, by selecting the desired one from a list of all registered handsets or by pressing the handset number.\n• Multiple From Any Handset/Base: Deregistration can be done from any handset or the base, and multiple handsets can be deregistered at once. If using a handset and you choose to deregister that one, it will be deregistered after the other handset(s) if any others were selected.\n• All From Base: You can deregister all handsets at once using the base. On most phones with this deregistration method, handsets are removed from the base memory, and handsets will see that they've been deregistered the next time they try to come in range of the base.")
                        Picker("Handset/Base Renaming", selection: $phone.handsetRenaming) {
                            Text("Not Supported").tag(0)
                            Text("Handset").tag(1)
                            if phone.baseDisplayType > 2 {
                                Text("Handset/Base").tag(2)
                            }
                        }
                        InfoText("Renaming the handset/base makes it easier to find the desired one in a list (e.g., when making intercom calls) and/or so you know where to put it. For example, if you have a handset in your kitchen, living room, and master bedroom, you might give each handset the names \"Kitchen\", \"Living RM\", and \"Bedroom\", respectively.\nIf the handset name shows in handset lists, the name is stored in the base, and the handset either links to the base when showing handset lists or syncs the list from the base.")
                    }
                } else {
                    Picker("Corded Phone Type", selection: $phone.cordedPhoneType) {
                        Section(header: Text("Desk")) {
                            Text("Push-Button Desk").tag(0)
                            Text("Rotary Desk").tag(1)
                        }
                        Section(header: Text("Slim/Wall")) {
                            Text("Push-Button Slim/Wall").tag(2)
                            Text("Rotary Slim/Wall").tag(3)
                        }
                        Section(header: Text("Vintage/Replicas")) {
                            Text("Candlestick").tag(6)
                            Text("Wooden Box").tag(7)
                        }
                        Section(header: Text("Other")) {
                            Text("Base-less").tag(4)
                            Text("Novelty").tag(5)
                        }
                    }
                    .onChange(of: phone.cordedPhoneType) { oldValue, newValue in
                        phone.cordedPhoneTypeChanged(oldValue: oldValue, newValue: newValue)
                    }
                    InfoButton(title: "About Corded Phone Types…") {
                        dialogManager.showingAboutCordedPhoneTypes = true
                    }
                }
                if phone.cordedPhoneType == 0 {
                    Toggle("Has Dual Receivers", isOn: $phone.hasDualReceivers)
                    InfoText("A corded phone with dual receivers allows 2 people to use the phone at the same time without having to connect 2 separate phones to the same line. These kinds of phones are often used by those requiring a language interpreter.")
                }
                if phone.isSlimCorded {
                    Picker("\(phone.cordedPhoneType == 2 ? "Keypad" : "Rotary Dial") Location", selection: $phone.dialLocation) {
                        Text("Base").tag(0)
                        Text("Receiver").tag(1)
                    }
                }
                Picker("Corded Receiver Volume Adjustment", selection: $phone.cordedReceiverVolumeAdjustmentType) {
                    Text("None").tag(0)
                    Text("Volume Switch/Dial").tag(1)
                    Text("Volume Button(s)").tag(2)
                }
                if phone.cordedReceiverVolumeAdjustmentType == 0 {
                    WarningText("If the corded receiver volume isn't adjustable and you find it too loud, you'll need to adjust your line's incoming volume. If you can't adjust it, adding a series of resistors between the phone and jack is recommended (consult a professional to build this for you if necessary). If the corded receiver's cord is removable, you can replace it with one that has a volume control.")
                }
                Toggle("Has Hard-Wired Corded Receiver", isOn: $phone.hasHardWiredCordedReceiver)
                InfoText("Some old phones have hard-wired corded receivers, which means you'll need to have the phone repaired if the cord breaks.")
                if phone.isPushButtonCorded {
                    Picker("Switch Hook", selection: $phone.switchHookType) {
                        Text(phone.isSlimCorded ? "Press (On Base)" : "Press").tag(0)
                        if phone.isSlimCorded {
                            Text("Press (On Receiver)").tag(1)
                        }
                        Text("Magnetic").tag(2)
                        Text("Contacts").tag(3)
                    }
                }
                InfoText("Most corded phones have a switch hook which presses, located on either the base (pressed by the receiver) or the receiver (pressed by the base). More advanced corded phones might have magnetic switch hooks, where magnets in the base and receiver trigger a magnetically-activated switch, called a reed switch. Some corded phones might use contacts like those found on cordless phones, instead of a switch hook. This is mostly seen on corded phones which are extensions of a cordless system, where placing the corded receiver on the cordless base registers the corded extension phone to the base.")
            }
            if phone.isCordedCordless || (!phone.isCordless && phone.isPushButtonCorded) {
                Picker("Corded Receiver Hook Type", selection: $phone.cordedReceiverHookType) {
                    Text("Fixed").tag(0)
                    Text("Flip/Rotate").tag(1)
                    Text("Removable").tag(2)
                }
                InfoText("The corded receiver hook holds it in place when the phone is wall-mounted, which prevents it from falling off the base. This is not to be confused with the switch hook, which is what tells the phone whether it's on or off-hook.\n• Fixed: The phone has a hook that slots into a hole on the corded receiver below the earpiece. On slim/wall phones where the switch hook is on the receiver instead of on the base, the switch hook is located directly below this hole and gets pressed by the hook on the base.\n• Flip/Rotate: The hook can be flipped or rotated so it sticks out when you want to mount the phone on the wall, or so it doesn't stick out when you don't want to mount it on the wall.\n• Removable: The phone has a removable hook which is inserted one way for desk use and another way for wall use. This is the most common type of corded receiver hook and has the risk of getting lost.")
            }
        }
    }

}

// MARK: - Preview

#Preview {
    Form {
        PhoneGeneralView(phone: Phone(brand: "Panasonic", model: "KX-TGE263"))
            .environmentObject(DialogManager())
            .environmentObject(PhonePhotoViewModel())
    }
    .formStyle(.grouped)
}
