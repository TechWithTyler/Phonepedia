//
//  PhoneRowView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 6/16/23.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI

struct PhoneRowView: View {

    // MARK: - Properties - Booleans

    @AppStorage(UserDefaults.KeyNames.showPhoneTypeInList) var showPhoneTypeInList: Bool = true

    @AppStorage(UserDefaults.KeyNames.showAnsweringSystemInList) var showAnsweringSystemInList: Bool = true

    @AppStorage(UserDefaults.KeyNames.showPhoneActiveStatusInList) var showPhoneActiveStatusInList: Bool = true

    @AppStorage(UserDefaults.KeyNames.showNumberOfCordlessHandsetsInList) var showNumberOfCordlessHandsetsInList: Bool = true

    @AppStorage(UserDefaults.KeyNames.highlightHandsetNumberDigitInList) var highlightHandsetNumberDigitInList: Int = 2

    @AppStorage(UserDefaults.KeyNames.showPhoneColorsInList) var showPhoneColorsInList: Bool = true

    @AppStorage(UserDefaults.KeyNames.showYearsInList) var showYearsInList: Bool = true

    @AppStorage(UserDefaults.KeyNames.showFrequencyInList) var showFrequencyInList: Bool = true

    // MARK: - Properties - Strings

    var phoneTypeText: String {
        if phone.isCordless && showFrequencyInList {
            return "\(Phone.CordlessFrequency.nameFromRawValue(phone.frequency)) \(phone.phoneTypeText)"
        } else {
            return phone.phoneTypeText
        }
    }

    var answeringSystemText: String {
        if phone.hasAnsweringSystem > 0 {
            return phone.answeringSystemType == 1 ? "With digital answering system" : "With tape answering system"
        } else {
            return "No answering system"
        }
    }

    // MARK: - Properties - Phone

	@Bindable var phone: Phone
    
    // MARK: - Body

    var body: some View {
		HStack {
            VStack {
                Text("\(phone.phoneNumberInCollection + 1)")
                if phone.acquiredInYearOfRelease {
                    Image(systemName: "sparkle")
                }
            }
            PhoneImage(phone: phone, mode: .thumbnail)
            Spacer()
            if showPhoneColorsInList {
                phoneColorStack
            }
            Spacer()
			VStack {
				Text(phone.brand)
					.font(.largeTitle)
                    .lineLimit(nil)
                    .multilineTextAlignment(.center)
                Text(modelNumberWithIndicatedHandsetNumberDigit(phone.model, digit: phone.handsetNumberDigit, at: phone.handsetNumberDigitIndex))
					.font(.title2)
                    .lineLimit(nil)
                    .multilineTextAlignment(.center)
                    .animation(.linear, value: phone.handsetNumberDigitIndex)
                if !phone.nickname.isEmpty {
                    Text("\"\(phone.nickname)\"")
                        .font(.title3)
                        .lineLimit(nil)
                        .multilineTextAlignment(.center)
                }
                phoneDetailStack
			}
			Spacer()
		}
    }

    @ViewBuilder
    var phoneColorStack: some View {
        VStack {
            colorCircle(for: phone.baseMainColorBinding.wrappedValue)
            if phone.hasSecondaryColor {
                colorCircle(for: phone.baseSecondaryColorBinding.wrappedValue)
            }
            if phone.hasAccentColor {
                colorCircle(for: phone.baseAccentColorBinding.wrappedValue)
            }
        }
    }

    @ViewBuilder
    var phoneDetailStack: some View {
        if showYearsInList {
            if phone.acquiredInYearOfRelease {
                Text("Released and acquired \(String(phone.acquisitionYear))")
                    .font(.callout)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    Text("Acquired the year it was released!")
                        .font(.callout)
                        .multilineTextAlignment(.center)
                        .lineLimit(nil)
            } else {
                Text("Released \(String(phone.releaseYear))")
                    .font(.callout)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                Text("Acquired \(String(phone.acquisitionYear))")
                    .font(.callout)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
            }
        }
        if showPhoneTypeInList {
            Text(phoneTypeText)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .lineLimit(nil)
        }
        if showAnsweringSystemInList {
            Text(answeringSystemText)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .lineLimit(nil)
        }
        if showNumberOfCordlessHandsetsInList && phone.isCordless {
            if phone.numberOfIncludedCordlessHandsets == phone.cordlessHandsetsIHave.count {
                Text("\(phone.numberOfIncludedCordlessHandsets) \(phone.numberOfIncludedCordlessHandsets == 1 ? "Cordless handset" : "Cordless devices")")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
            } else {
                Text("\(phone.numberOfIncludedCordlessHandsets) \(phone.numberOfIncludedCordlessHandsets == 1 ? "Cordless handset included" : "cordless devices included")")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                Text("\(phone.cordlessHandsetsIHave.count) \(phone.cordlessHandsetsIHave.count == 1 ? "cordless device in collection" : "cordless devices in collection")")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
            }
        }
        if showPhoneActiveStatusInList {
            Text(phone.storageOrSetup > 1 ? "In storage" : "Active")
                .foregroundStyle(.secondary)
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .lineLimit(nil)
        }
    }

    @ViewBuilder
    func colorCircle(for color: Color) -> some View {
        Circle()
            .fill(color)
                   .overlay(
                       Circle()
                        .stroke(.primary, lineWidth: 1)
                   )
                   .frame(width: 10, height: 10)
    }

    // MARK: - Model Number "Number Of Included Cordless Devices" Digit Highlight

    func modelNumberWithIndicatedHandsetNumberDigit(_ modelNumber: String, digit: Int?, at index: Int?) -> AttributedString {
        // 1. Convert the model number String to an AttributedString. As AttributedString is a data type, it's declared in the Foundation framework instead of the SwiftUI framework, even though its cross-platform design makes it shine with SwiftUI. Unlike with NSAttributedString, you can simply initialize it with a String argument without having to use an argument label.
        var attributedString = AttributedString(modelNumber)
        // 2. Ensure digit and index aren't nil and that index is within modelNumber's bounds.
        if let digit = digit, let index = index, modelNumber.count > index, highlightHandsetNumberDigitInList > 0 {
            // 3. Calculate the String.Index for the given Int index.
            let stringIndex = modelNumber.index(modelNumber.startIndex, offsetBy: index)
            // 4. Check if the character at index matches digit.
            if modelNumber[stringIndex] == Character("\(digit)") {
                // 5. Calculate the range in AttributedString and apply highlighting.
                let attributedStartIndex = attributedString.index(attributedString.startIndex, offsetByCharacters: index)
                let attributedEndIndex = attributedString.index(afterCharacter: attributedStartIndex)
                // 6. Choose whether to apply an underline or highlight to the digit based on the "Handset Number Digit Indication" setting.
                switch highlightHandsetNumberDigitInList {
                case 2:
                    // Highlight
                    attributedString[attributedStartIndex..<attributedEndIndex].backgroundColor = .accentColor.opacity(0.75)
                    attributedString[attributedStartIndex..<attributedEndIndex].foregroundColor = .white
                default:
                    // Underline
                    attributedString[attributedStartIndex..<attributedEndIndex].underlineStyle = .single
                }
            }
        }
        // 7. Return the attributed string. If digit and index are nil in step 2, no highlighting/underlining is applied (steps 3-6 are skipped).
        return attributedString
    }

}

// MARK: - Preview

#Preview {
	PhoneRowView(phone: Phone(brand: "Panasonic", model: "KX-TGF975"))
        .modelContainer(for: Phone.self, inMemory: true)
}
