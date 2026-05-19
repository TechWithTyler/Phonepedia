//
//  PhoneAudioView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 10/3/24.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI
import SheftAppsStylishUI

struct PhoneAudioView: View {

    // MARK: - Properties - Phone

    @Bindable var phone: Phone

    // MARK: - Body

    var body: some View {
        Section("Headsets") {
            if phone.canTalkOnBase {
                Toggle(phone.isCordless ? "Base Supports Wired Headsets" : "Supports Wired Headsets", isOn: $phone.baseSupportsWiredHeadsets)
            }
            InfoText("Corded phones with a standard 2.5mm headset jack require the corded receiver to be picked up to use the headset. If a cordless headset phone base is connected to the headset jack, a lifter needs to be placed under the corded receiver and connected to the cordless headset phone base. This allows the corded receiver to be lifted or hung up when the cordless headset is turned on or off. A ring detector also needs to be placed on the speaker if it isn't located under the corded receiver. A ring detector tells the cordless headset to ring when it detects sound.\nMany modern VoIP corded phones use a technology called Electronic Hook Switch (EHS), where the headset jack doesn't carry a standard audio signal but instead carries control signals.")
            CountPicker(phone.isCordless ? "Maximum Number of Bluetooth Headphones (Base)" : "Maximum Number of Bluetooth Headphones", selection: $phone.baseBluetoothHeadphonesSupported, startNumber: 1, multipliedBy: 2, endNumber: 4, singularSuffix: "Bluetooth Headphone", pluralSuffix: "Bluetooth Headphones", noneTitle: "None", unlimitedTitle: "Unlimited")
        }
        if phone.landlineConnectionType > 0 {
            Section("Supported Audio Codecs") {
                Toggle(isOn: $phone.supportsULaw) {
                    VStack(alignment: .leading) {
                        Text("U-law (G.711 U-law or PCM-U)")
                        Text("Standard voice codec in North America and Japan; good quality, uncompressed. Often written as μ-law (with the Greek letter \"mu\" (μ) instead of \"u\", but pronounced \"U-law\"). Commonly used when connecting analog phones to digital networks.")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                Toggle(isOn: $phone.supportsALaw) {
                    VStack(alignment: .leading) {
                        Text("A-law (G.711 A-law or PCM-A)")
                        Text("Similar to μ-law but used mainly in Europe and international telephony. Commonly used when connecting analog phones to digital networks.")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                Toggle(isOn: $phone.supportsG722) {
                    VStack(alignment: .leading) {
                        Text("G.722")
                        Text("Wideband codec with higher voice quality than G.711. Used in HD voice.")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                Toggle(isOn: $phone.supportsG726) {
                    VStack(alignment: .leading) {
                        Text("G.726")
                        Text("ADPCM codec with flexible bitrate. Used in legacy and enterprise telephony.")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                if phone.landlineConnectionType > 1 {
                    Toggle(isOn: $phone.supportsOpus) {
                        VStack(alignment: .leading) {
                            Text("Opus")
                            Text("High-quality, low-latency codec suitable for voice and music over the internet.")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                    Toggle(isOn: $phone.supportsG729) {
                        VStack(alignment: .leading) {
                            Text("G.729")
                            Text("Compressed codec for low-bandwidth VoIP, with moderate voice quality.")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                    Toggle(isOn: $phone.supportsG723) {
                        VStack(alignment: .leading) {
                            Text("G.723")
                            Text("Low-bitrate codec used in early VoIP, suitable for bandwidth-limited environments.")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                    Toggle(isOn: $phone.supportsILBC) {
                        VStack(alignment: .leading) {
                            Text("iLBC (internet Low Bitrate Codec)")
                            Text("Resilient to packet loss. Good for VoIP over unreliable networks, but very low quality as a result.")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
            InfoText("An audio codec determines the audio quality and bandwidth used for VoIP, cellular, and digital lines.\nYou may think that with the G.7XX codecs, the higher number means better quality, but the numbering order isn't tied to quality--it's just arbitrary.")
        }
    }

}

// MARK: - Preview

#Preview {
    Form {
        PhoneAudioView(phone: Phone(brand: "Panasonic", model: "KX-TG7873"))
    }
    .formStyle(.grouped)
}
