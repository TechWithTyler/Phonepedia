//
//  PhoneCountView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 7/9/24.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI

struct PhoneCountView: View {

    // MARK: - Properties - Phones

    // All phones in the catalog.
    var phones: [Phone]

    // All cordless phones in the catalog.
    var cordlessPhones: [Phone] {
        return phones.filter({ $0.isCordless })
    }

    // MARK: - Properties - Dismiss Action

    @Environment(\.dismiss) var dismiss

    // MARK: - Properties - Integers

    // The selected sort order for the brand counts.
    @AppStorage(UserDefaults.KeyNames.brandSortMode) var brandSortMode: Int = 0

    // The total number of phones, not counting the individual cordless devices on each cordless phone system.
    var totalPhoneCount: Int {
        let count = phones.count
        return count
    }

    // The number of active phones, not counting the individual cordless devices on each cordless phone system.
    var activePhoneCount: Int {
        // 1. Filter the phones array to get all active phones (i.e. all phones where storageOrSetup is less than or equal to 1).
        let activePhones = phones.filter({$0.storageOrSetup <= 1})
        // 2. Get the number of active phones.
        let count = activePhones.count
        // 3. Return the count.
        return count
    }

    // The total number of cordless phones, not counting the individual cordless devices on each cordless phone system.
    var cordlessPhoneCount: Int {
        let count = cordlessPhones.count
        return count
    }

    // The total number of corded phones.
    var cordedPhoneCount: Int {
        // 1. Filter the phones array to get all corded phones (i.e. non-cordless phones where the phone type is set to 0).
        let cordedPhones = phones.filter({ !$0.isCordless && $0.basePhoneType == 0 })
        // 2. Get the number of corded phones.
        let count = cordedPhones.count
        // 3. Return the count.
        return count
    }

    // The total number of Wi-Fi handsets. Although these look and feel like cordless phones, they're not counted as cordless phones since they're standalone wireless handsets.
    var wiFiHandsetCount: Int {
        // 1. Filter the phones array to get all Wi-Fi handsets (i.e. non-cordless phones where the phone type is set to 1).
        let wiFiHandsets = phones.filter({ !$0.isCordless && $0.basePhoneType == 1 })
        // 2. Get the number of Wi-Fi handsets.
        let count = wiFiHandsets.count
        // 3. Return the count.
        return count
    }

    // The total number of cellular handsets. Although these look and feel like cordless phones, they're not counted as cordless phones since they're standalone wireless handsets.
    var cellularHandsetCount: Int {
        // 1. Filter the phones array to get all cellular handsets (i.e. non-cordless phones where the phone type is set to 2).
        let cellularHandsets = phones.filter({ !$0.isCordless && $0.basePhoneType == 2 })
        // 2. Get the number of cellular handsets.
        let count = cellularHandsets.count
        // 3. Return the count.
        return count
    }

    // The total number of cordless handsets across all phones.
    var handsetCount: Int {
        // 1. Create a variable to keep track of the total number of handsets.
        var totalHandsets = 0
        // 2. Add the total number of handsets (cordless device type 0) the user has added to each cordless phone.
        for phone in cordlessPhones {
            let handsets = phone.cordlessHandsetsIHave.filter({$0.cordlessDeviceType == 0})
            totalHandsets += handsets.count
        }
        // 3. Return the count.
        return totalHandsets
    }

    // The number of active cordless handsets across all phones.
    var activeCordlessHandsetCount: Int {
        // 1. Create a variable to keep track of the total number of active handsets.
        var activeHandsetCount = 0
        // 2. Add the total number of active handsets the user has added to each cordless phone. This is done by filtering the phone's cordlessHandsetsIHave array to get only active cordless handsets (i.e. all cordless devices where storageOrSetup is less than or equal to 1 and cordlessDeviceType is 0).
        for phone in cordlessPhones {
            let activeHandsets = phone.cordlessHandsetsIHave.filter({$0.storageOrSetup <= 1 && $0.cordlessDeviceType == 0})
            activeHandsetCount += activeHandsets.count
        }
        // 3. Return the count.
        return activeHandsetCount
    }

    // The total number of cordless desksets across all phones.
    var desksetCount: Int {
        // 1. Create a variable to keep track of the total number of desksets.
        var totalDesksets = 0
        // 2. Add the total number of desksets (cordless device type 1) the user has added to each cordless phone.
        for phone in cordlessPhones {
            let desksets = phone.cordlessHandsetsIHave.filter({$0.cordlessDeviceType == 1})
            totalDesksets += desksets.count
        }
        // 3. Return the count.
        return totalDesksets
    }

    // The number of active cordless desksets across all phones.
    var activeCordlessDesksetCount: Int {
        // 1. Create a variable to keep track of the total number of active desksets.
        var activeDesksetCount = 0
        // 2. Add the total number of active desksets the user has added to each cordless phone. This is done by filtering the phone's cordlessHandsetsIHave array to get only active cordless desksets (i.e. all cordless devices where storageOrSetup is less than or equal to 1 and cordlessDeviceType is 1).
        for phone in cordlessPhones {
            let activeDesksets = phone.cordlessHandsetsIHave.filter({$0.storageOrSetup <= 1 && $0.cordlessDeviceType == 1})
            activeDesksetCount += activeDesksets.count
        }
// 3. Return the count.
        return activeDesksetCount
    }

    // The total number of cordless headsets/speakerphones across all phones.
    var headsetCount: Int {
        // 1. Create a variable to keep track of the total number of headsets.
        var totalHeadsets = 0
        // 2. Add the total number of headsets (cordless device type 2) the user has added to each cordless phone.
        for phone in cordlessPhones {
            let headsets = phone.cordlessHandsetsIHave.filter({$0.cordlessDeviceType == 2})
            totalHeadsets += headsets.count
        }
        // 3. Return the count.
        return totalHeadsets
    }

    // The number of active cordless headsets/speakerphones across all phones.
    var activeCordlessHeadsetCount: Int {
        // 1. Create a variable to keep track of the total number of active headsets.
        var activeHeadsetCount = 0
        // 2. Add the total number of active headsets the user has added to each cordless phone. This is done by filtering the phone's cordlessHandsetsIHave array to get only active cordless headsets (i.e. all cordless devices where storageOrSetup is less than or equal to 1 and cordlessDeviceType is 2).
        for phone in cordlessPhones {
            let activeHeadsets = phone.cordlessHandsetsIHave.filter({$0.storageOrSetup <= 1 && $0.cordlessDeviceType == 2})
            activeHeadsetCount += activeHeadsets.count
        }
// 3. Return the count.
        return activeHeadsetCount
    }

    // The total number of phones with answering systems.
    var withAnsweringSystemsCount: Int {
        // 1. Filter the phones array to get all phones with answering systems.
        let phonesWithAnsweringSystems = phones.filter({ $0.hasAnsweringSystem > 0 })
        // 2. Get the number of phones with answering systems.
        let count = phonesWithAnsweringSystems.count
        // 3. Return the count.
        return count
    }

    // The total number of phones with Bluetooth cell phone linking.
    var withBluetoothCellPhoneLinkingCount: Int {
        // 1. Filter the phones array to get all phones with Bluetooth cell phone linking.
        let bluetoothCellLinkingPhones = phones.filter({ $0.baseBluetoothCellPhonesSupported > 0 })
        // 2. Get the number of phones with Bluetooth cell phone linking.
        let count = bluetoothCellLinkingPhones.count
        // 3. Return the count.
        return count
    }

    // The total number of phones acquired in their release year.
    var acquiredInReleaseYearCount: Int {
        // 1. Filter the phones array to get all phones acquired in their release year.
        let phonesAcquiredInReleaseYear = phones.filter({$0.acquiredInYearOfRelease})
        // 2. Get the total number of phones acquired in their release year.
        let count = phonesAcquiredInReleaseYear.count
        // 3. Return the count.
        return count
    }

    // MARK: - Properties - Doubles

    // The average number of cordless handsets per cordless phone.
    var averageHandsetsPerCordlessPhone: Double {
        // 1. If there are no cordless phones, return 0.
        guard cordlessPhoneCount > 0 else { return 0 }
        // 2. Divide the number of handsets by the number of cordless phones to get the average.
        let average = Double(handsetCount) / Double(cordlessPhoneCount)
        // 3. Return the average.
        return average
    }

    // The average number of cordless desksets per cordless phone.
    var averageDesksetsPerCordlessPhone: Double {
        // 1. If there are no cordless phones, return 0.
        guard cordlessPhoneCount > 0 else { return 0 }
        // 2. Divide the number of desksets by the number of cordless phones to get the average.
        let average = Double(desksetCount) / Double(cordlessPhoneCount)
        // 3. Return the average.
        return average
    }

    // The average number of cordless headsets/speakerphones per cordless phone.
    var averageHeadsetsPerCordlessPhone: Double {
        // 1. If there are no cordless phones, return 0.
        guard cordlessPhoneCount > 0 else { return 0 }
        // 2. Divide the number of headsets/speakerphones by the number of cordless phones to get the average.
        let average = Double(headsetCount) / Double(cordlessPhoneCount)
        // 3. Return the average.
        return average
    }

    // Years that phones were acquired in.
    var acquisitionYears: [Int] {
        // 1. Create a dictionary to count the number of phones acquired in each year (only includes years when phones were acquired), where the key is the year and the value is the number of times the year exists in the array. This is only used for sorting--the counts themselves aren't returned here.
        var yearCounts: [Int : Int] = [:]
        // 2. Loop through each phone in the phones array and count the occurrences of each year (when this phone was acquired and when the phone this one replaced, if any, was acquired). If the respective value is 0, don't add it to the count.
        for phone in phones {
            if phone.acquisitionYear > 0 {
                yearCounts[phone.acquisitionYear, default: 0] += 1
            }
            if phone.replacesPhoneAcquiredInYear > 0 {
                yearCounts[phone.replacesPhoneAcquiredInYear, default: 0] += 1
            }
        }
        // 3. Sort based on year.
        return yearCounts.keys.sorted(by: >)
    }

    // MARK: - Properties - Strings

    // Brands of phones. Unlike the allBrands property in PhoneListView, this property is an array so a brand can exist more than once to count them.
    var brands: [String] {
        // 1. Create a dictionary to count the number of phones for each brand, where the key is the brand name and the value is the number of times the brand exists in the array. This is only used for sorting--the counts themselves aren't returned here.
        var brandCounts: [String : Int] = [:]
        // 2. Loop through each phone in the phones array and count the occurrences of each brand.
        for phone in phones {
            brandCounts[phone.brand, default: 0] += 1
        }
        // 3. Sort based on the selected sort mode. Brands will be sorted alphabetically if sorting by name (brandSortMode is 0), or numerically in descending order if sorting by count (brandSortMode is 1). For any counts that are tied (i.e. 2 or more brands with the same count), sort those brands alphabetically. In the brandCounts dictionary, the key is the brand and the value is the number of phones of that brand.
        if brandSortMode == 0 {
            // Sort alphabetically by brand name.
            return brandCounts.keys.sorted(by: <)
        } else {
            // Sort by the number of phones, then alphabetically for ties.
            return brandCounts.sorted {
                if $0.value == $1.value {
                    return $0.key < $1.key // Sort alphabetically if counts are equal.
                }
                return $0.value > $1.value // Sort numerically in descending order.
            }.map { $0.key } // Return only the brand names.
        }
    }

    // MARK: - Body

    var body: some View {
        NavigationStack {
            List {
                PhoneCollectionStabilityView(phones: phones)
                DisclosureGroup("Total (\(totalPhoneCount))") {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Total Phone Sets")
                                .foregroundStyle(.primary)
                                .multilineTextAlignment(.leading)
                            excludingHandsetsText
                        }
                        Spacer()
                        Text(totalPhoneCount, format: .number)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Acquired In Release Year")
                                .foregroundStyle(.primary)
                                .multilineTextAlignment(.leading)
                            excludingHandsetsText
                        }
                        Spacer()
                        Text(acquiredInReleaseYearCount, format: .number)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Cordless Phone Sets")
                                .foregroundStyle(.primary)
                                .multilineTextAlignment(.leading)
                            excludingHandsetsText
                        }
                        Spacer()
                        Text(cordlessPhoneCount, format: .number)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("Corded Phones")
                            .foregroundStyle(.primary)
                            .multilineTextAlignment(.leading)
                        Spacer()
                        Text(cordedPhoneCount, format: .number)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("Wi-Fi Handsets")
                            .foregroundStyle(.primary)
                            .multilineTextAlignment(.leading)
                        Spacer()
                        Text(wiFiHandsetCount, format: .number)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("Cellular Handsets")
                            .foregroundStyle(.primary)
                            .multilineTextAlignment(.leading)
                        Spacer()
                        Text(cellularHandsetCount, format: .number)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Total Cordless Handsets")
                                .foregroundStyle(.primary)
                            averageText(averageHandsetsPerCordlessPhone)
                        }
                        Spacer()
                        Text(handsetCount, format: .number)
                            .foregroundStyle(.secondary)
                    }
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Total Cordless Desksets")
                                .foregroundStyle(.primary)
                            averageText(averageDesksetsPerCordlessPhone)
                        }
                        Spacer()
                        Text(desksetCount, format: .number)
                            .foregroundStyle(.secondary)
                    }
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Total Cordless Headsets/Speakerphones")
                                .foregroundStyle(.primary)
                            averageText(averageHeadsetsPerCordlessPhone)
                        }
                        Spacer()
                        Text(headsetCount, format: .number)
                            .foregroundStyle(.secondary)
                    }
                }
                DisclosureGroup("Active (\(activePhoneCount))") {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Active Phone Sets")
                                .foregroundStyle(.primary)
                                .multilineTextAlignment(.leading)
                            excludingHandsetsText
                        }
                        Spacer()
                        Text(activePhoneCount, format: .number)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.trailing)
                    }
                    if handsetCount > 0 {
                        HStack {
                            Text("Active Cordless Handsets")
                                .foregroundStyle(.primary)
                                .multilineTextAlignment(.leading)
                            Spacer()
                            Text(activeCordlessHandsetCount, format: .number)
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.trailing)
                        }
                    }
                    if desksetCount > 0 {
                        HStack {
                            Text("Active Cordless Desksets")
                                .foregroundStyle(.primary)
                                .multilineTextAlignment(.leading)
                            Spacer()
                            Text(activeCordlessDesksetCount, format: .number)
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.trailing)
                        }
                    }
                    if headsetCount > 0 {
                        HStack {
                            Text("Active Cordless Headsets/Speakerphones")
                                .foregroundStyle(.primary)
                                .multilineTextAlignment(.leading)
                            Spacer()
                            Text(activeCordlessHeadsetCount, format: .number)
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.trailing)
                        }
                    }
                }
                DisclosureGroup("Features") {
                    HStack {
                        Text("With Answering Systems")
                            .foregroundStyle(.primary)
                            .multilineTextAlignment(.leading)
                        Spacer()
                        Text(withAnsweringSystemsCount, format: .number)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("With Bluetooth Cell Phone Linking")
                            .foregroundStyle(.primary)
                            .multilineTextAlignment(.leading)
                        Spacer()
                        Text(withBluetoothCellPhoneLinkingCount, format: .number)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.trailing)
                    }
                }
                DisclosureGroup("Acquisition Years") {
                    ForEach(acquisitionYears, id: \.self) { year in
                        HStack {
                            Text("Phones Acquired In \(formattedYear(year))")
                                .foregroundStyle(.primary)
                                .multilineTextAlignment(.leading)
                            Spacer()
                            Text(numberOfPhonesAcquiredInYear(year), format: .number)
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.trailing)
                        }
                    }
                }
                DisclosureGroup("Brands (\(brands.count))") {
                    Picker("Sort By", selection: $brandSortMode) {
                        Text("Name").tag(0)
                        Text("Count").tag(1)
                    }
                    .pickerStyle(.segmented)
                    ForEach(brands, id: \.self) { brand in
                        HStack {
                            Text("\(brand) Phones")
                                .foregroundStyle(.primary)
                                .multilineTextAlignment(.leading)
                                .onTapGesture {
                                    brandSortMode = 0
                                }
                            Spacer()
                            Text(numberOfPhones(of: brand), format: .number)
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.trailing)
                                .onTapGesture {
                                    brandSortMode = 1
                                }
                        }
                    }
                }
            }
            .animation(.linear, value: brandSortMode)
            .navigationTitle("Phone Count")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("OK") {
                        dismiss()
                    }
                    .keyboardShortcut(.defaultAction)
                }
            }
        }
#if os(macOS)
        .frame(minWidth: 550, maxWidth: 550, minHeight: 350, maxHeight: 350)
#endif
    }

    // MARK: - Average Text

    @ViewBuilder
    func averageText(_ value: Double) -> some View {
        let roundedValue = value.rounded()
        Text("Average \(Int(roundedValue)) per cordless phone")
            .foregroundStyle(.secondary)
            .font(.footnote)
    }

    // MARK: - "Excluding Handsets" Text

    @ViewBuilder
    var excludingHandsetsText: some View {
        Text("Excluding individual cordless devices")
            .foregroundStyle(.secondary)
            .font(.footnote)
    }

    // MARK: - Formatted Year

    // This method formats year as a String without a grouping separator.
    func formattedYear(_ year: Int) -> String {
        // 1. Convert the year to a string without formatting in case formatting returns nil.
        let yearAsString = "\(year)"
        // 2. Format the year.
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = false
        guard let formattedYear = formatter.string(from: year as NSNumber) else { return yearAsString }
        // 3. Return the formatted year.
        return formattedYear
    }

    // MARK: - Number of Phones Acquired In Year

    // This method returns the number of phones acquired in year. The acquisitionYears array stores only the years--the number of phones acquired in each year is determined here based on how many instances of year are in the array.
    func numberOfPhonesAcquiredInYear(_ year: Int) -> Int {
        // 1. Filter the phones array to get all phones acquired in year.
        let allPhonesAcquiredInYear = phones.filter { $0.acquisitionYear == year || $0.replacesPhoneAcquiredInYear == year }
        // 2. Get the total number of phones acquired in year.
        let count = allPhonesAcquiredInYear.count
        // 3. Return the count.
        return count
    }

    // MARK: - Number of Phones of Brand

    // This method returns the number of phones of brand. The brands array stores only the brand names--the number of phones of each brand is determined here based on how many instances of brand are in the array.
    func numberOfPhones(of brand: String) -> Int {
        // 1. Filter the phones array to get all phones of brand.
        let allPhonesOfBrand = phones.filter { $0.brand == brand }
        // 2. Get the total number of phones of brand.
        let count = allPhonesOfBrand.count
        // 3. Return the count.
        return count
    }

}

// MARK: - Preview

#Preview {
    PhoneCountView(phones: [Phone(brand: "Panasonic", model: "KX-TG9582")])
}
