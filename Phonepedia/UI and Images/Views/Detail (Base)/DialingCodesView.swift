//
//  DialingCodesView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 10/3/24.
//  Copyright © 2023-2024 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct DialingCodesView: View {

    @Bindable var phone: Phone

    @EnvironmentObject var dialogManager: DialogManager

    var body: some View {
        if phone.hasCallerIDList {
            Picker("Landline Local Area Code Features", selection: $phone.landlineLocalAreaCodeFeatures) {
                Text("None").tag(0)
                Text("Your Area Code").tag(1)
                Text("Yours + Overlay").tag(2)
                Text("Auto-Format").tag(3)
            }
            InfoText("Your Area Code: You can store your area code so calls from that area code will appear as 7 digits. This is useful if your provider requires local calls to be dialed with only 7 digits.\nYours + Overlay: You can store the additional area code(s) for your area (overlay area codes) in addition to your area code. The phone can choose which area code to use when dialing only 7 digits, by remembering a number's prefix (the digits after the area code but before the last digits) when calling back the 10-digit number in the caller ID list.\nAuto-Format: Instead of storing area codes yourself, you can edit the format of a caller ID entry and the phone will display all caller ID entries from that area code in the desired format. Different formats, including whether the trunk prefix should be included, can be remembered for multiple area codes (e.g., your area code and your area's overlay area code(s)).\nThese features only apply to numbers dialed from the caller ID list.")
        }
        Toggle("Can Add PBX Line Access Number", isOn: $phone.supportsAddingOfPBXLineAccessNumber)
        InfoText("If you're using the phone on a PBX (private branch exchange) system, storing the line access number allows the phone to automatically dial it before the outside number you dialed.")
        if phone.baseBluetoothCellPhonesSupported > 0 {
            Toggle("Can Add Area Code To 7-Digit Cell Calls", isOn: $phone.supportsAddingOfCellAreaCode)
            InfoText("Storing your cell area code allows you to:\n• For phones where transferred cell phonebook entries are stored separately from the home phonebook, edit the format of an entry to include the cell area code so it can be dialed on the landline if it requires 10-digit dialing.\n• Auto-add the cell area code to 7-digit numbers dialed on the cell line if your cell phone requires 10-digit dialing.\nThe available uses of the stored cell area code depends on the phone's features.")
        }
        Toggle("Supports Dialing Of International Code", isOn: $phone.supportsDialingOfInternationalCode)
        InfoText("Storing your international code for automatic dialing includes the international dialing symbol (+) as one of the options for editing the format of a displayed phone number (e.g., in the caller ID list). For example, if a caller ID list entry's phone number is 442034567890, and you're in the US where the international code is 011, you can edit the format to include the international dialing prefix so it will be displayed as +442034567890 and dialed as 011442034567890.")
        if phone.bluetoothPhonebookTransfers > 0 {
            Toggle("Can Store Dialing Codes For Phonebook Transfer", isOn: $phone.supportsPhonebookTransferDialingCodes)
        }
        InfoButton(title: "About Dialing Codes…") {
            dialogManager.showingAboutDialingCodes = true
        }
    }
}

#Preview {
    Form {
        DialingCodesView(phone: Phone(brand: "Panasonic", model: "KX-TGF575"))
            .environmentObject(DialogManager())
    }
    .formStyle(.grouped)
}
