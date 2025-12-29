//
//  DialingCodesView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 10/3/24.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI
import SheftAppsStylishUI

struct DialingCodesView: View {

    // MARK: - Properties - Objects

    @Bindable var phone: Phone

    @EnvironmentObject var dialogManager: DialogManager

    // MARK: - Body

    var body: some View {
        if phone.hasCallerIDList {
            Picker("Landline Local Area Code Features", selection: $phone.landlineLocalAreaCodeFeatures) {
                Text("None").tag(0)
                Divider()
                Text("Your Area Code").tag(1)
                Text("Yours + Add'l").tag(2)
                Divider()
                Text("Auto-Format").tag(3)
            }
            InfoText("• None: Phone numbers in the caller ID list will always appear as sent by the provider, so you may need to use the edit option (if the phone has one) if you want to call back from the caller ID list. Depending on the phone, this adds/removes the area code and/or trunk prefix, or allows you to add/remove any digits from the number.\n• Your Area Code: You can store your area code so calls from that area code will only be shown as a 7-digit number when received or when viewed in the caller ID list. This is useful if your provider requires local calls to be dialed with only 7 digits.\n• Yours + Add'l: You can store the additional area code(s) for your area (split and/or overlay area codes) in addition to your local area code. The trunk prefix (e.g. 1 in the US/Canada) won't be added to numbers in your additional area codes, since a call to a number in your additional area codes might still be considered a local call despite the different area code.\n• Auto-Format: Instead of storing area codes yourself, the phone can remember the format you selected with the edit option when dialing a phone number from the caller ID list, and apply that format to all entries with the same area code. Different formats, including whether the trunk prefix should be included, can be remembered for multiple area codes (e.g., your area code and your area's additional area code(s)).\nA split is when one area code is split into 2, forcing some numbers (usually just their area codes) to be changed. This is why you might encounter the message, \"The area code for the number you have dialed has been changed to XXX. Please redial using the new area code XXX.\", where XXX represents an area code. An overlay is when a new area code is created without changing any numbers in the original area code. In some cases, a call to a number in a split area code is considered a long-distance call, so you'll need to re-add the trunk prefix before dialing if your provider requires it.\nThese features only apply to incoming caller ID and numbers dialed from the caller ID list.")
        }
        if phone.hasPhonebook || phone.hasCallerIDList {
            if phone.baseBluetoothCellPhonesSupported > 0 {
                Toggle("Can Add Area Code To 7-Digit Cell Calls", isOn: $phone.supportsAddingOfCellAreaCode)
                InfoText("Storing your cell area code allows you to:\n• For phones where transferred cell phonebook entries are stored separately from the home phonebook, edit the format of an entry to include the cell area code so it can be dialed on the landline if it requires 10-digit dialing.\n• Auto-add the cell area code to 7-digit numbers dialed on the cell line if your cell phone requires 10-digit dialing.\nThe available uses of the stored cell area code depends on the phone's features.")
            }
            Toggle("Supports Dialing Of International Code", isOn: $phone.supportsDialingOfInternationalCode)
            InfoText("Storing your international code for automatic dialing includes the international dialing symbol (+) as one of the options for editing the format of a displayed phone number (e.g., in the caller ID list). For example, if a caller ID list entry's phone number is 442045678901 and sent without the international code, and you're in the US where the international code is 011, you can edit the format to include the international dialing prefix so it will be displayed as +442045678901 and dialed as 011442045678901.")
            if phone.bluetoothPhonebookTransfers > 0 {
                Toggle("Can Store Dialing Codes For Phonebook Transfer", isOn: $phone.supportsPhonebookTransferDialingCodes)
            }
        }
        Toggle("Can Add PBX Line Access Number", isOn: $phone.supportsAddingOfPBXLineAccessNumber)
        InfoText("If you're using the phone on a PBX (private branch exchange) system which requires dialing one or more digits to access an outside line (called the PBX line access number), storing the line access number allows the phone to automatically dial it before the outside number you dialed. Depending on the PBX, it may be necessary to add one or more pauses after the line access number. On software-based VoIP PBX systems, a line access number typically isn't needed--the system uses the length of the dialed number to determine whether it's an internal call or an outside call.")
        InfoButton("About Dialing Codes…") {
            dialogManager.showingAboutDialingCodes = true
        }
    }

}

// MARK: - Preview

#Preview {
    Form {
        DialingCodesView(phone: Phone(brand: "Panasonic", model: "KX-TGF575"))
            .environmentObject(DialogManager())
    }
    .formStyle(.grouped)
}
