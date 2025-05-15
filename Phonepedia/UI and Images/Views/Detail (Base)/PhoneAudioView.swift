//
//  PhoneAudioView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 10/3/24.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct PhoneAudioView: View {

    @Bindable var phone: Phone

    var body: some View {
        Section("Headsets") {
            if phone.hasCordedReceiver || phone.hasBaseSpeakerphone {
                Toggle(phone.isCordless ? "Base Supports Wired Headsets" : "Supports Wired Headsets", isOn: $phone.baseSupportsWiredHeadsets)
            }
            Picker(phone.isCordless ? "Maximum Number Of Bluetooth Headphones (base)" : "Maximum Number Of Bluetooth Headphones", selection: $phone.baseBluetoothHeadphonesSupported) {
                Text("None").tag(0)
                Divider()
                Text("1").tag(1)
                Text("2").tag(2)
                Text("4").tag(4)
                Divider()
                Text("Unlimited").tag(Int.max)
            }
        }
        if phone.landlineConnectionType > 0 {
        Section("Supported Audio Codecs") {
                Toggle(isOn: $phone.supportsULaw) {
                    VStack(alignment: .leading) {
                        Text("U-law (G.711 U-law or PCM-U)")
                        Text("Standard voice codec in North America and Japan; good quality, uncompressed. Often written as μ-law (with the Greek letter \"mu\" (μ) instead of \"u\", but pronounced \"U-law\"). Commonly used when connecting analog phones to digital networks.")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                Toggle(isOn: $phone.supportsALaw) {
                    VStack(alignment: .leading) {
                        Text("A-law (G.711 A-law or PCM-A)")
                        Text("Similar to μ-law but used mainly in Europe and international telephony. Commonly used when connecting analog phones to digital networks.")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                Toggle(isOn: $phone.supportsG722) {
                    VStack(alignment: .leading) {
                        Text("G.722")
                        Text("Wideband codec with higher voice quality than G.711; used in HD voice.")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                Toggle(isOn: $phone.supportsG726) {
                    VStack(alignment: .leading) {
                        Text("G.726")
                        Text("ADPCM codec with flexible bitrate; used in legacy and enterprise telephony.")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                if phone.landlineConnectionType > 1 {
                    Toggle(isOn: $phone.supportsOpus) {
                        VStack(alignment: .leading) {
                            Text("Opus")
                            Text("High-quality, low-latency codec suitable for voice and music over the internet.")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    Toggle(isOn: $phone.supportsG729) {
                        VStack(alignment: .leading) {
                            Text("G.729")
                            Text("Compressed codec for low-bandwidth VoIP, with moderate voice quality.")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    Toggle(isOn: $phone.supportsG723) {
                        VStack(alignment: .leading) {
                            Text("G.723")
                            Text("Low-bitrate codec used in early VoIP; suitable for bandwidth-limited environments.")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    Toggle(isOn: $phone.supportsILBC) {
                        VStack(alignment: .leading) {
                            Text("iLBC (internet Low Bitrate Codec)")
                            Text("Resilient to packet loss; good for VoIP over unreliable networks, but very low quality as a result.")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            InfoText("An audio codec determines the audio quality and bandwidth used for VoIP, cellular, and ISDN digital lines.\nYou may think that with the G.7XX codecs, the higher number means better quality, but the numbering order isn't tied to quality--it's just arbitrary.")
        }
    }
}

#Preview {
    Form {
        PhoneAudioView(phone: Phone(brand: "Panasonic", model: "KX-TG7873"))
    }
    .formStyle(.grouped)
}
