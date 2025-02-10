//
//  CordlessFrequency.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 1/24/25.
//  Copyright © 2025 SheftApps. All rights reserved.
//

extension Phone {

    enum CordlessFrequency: Double, CaseIterable, Identifiable {

        case unknown = 0.0
        case separator1 = -1.0

        // Older
        case analog1_7MHz = 1.0
        case analog30_39MHz = 30.0
        case analog46_49MHz = 46.0
        case analog46_49MHzVoiceScramble = 46.1
        case separator2 = -1.1

        // 900MHz
        case analog900MHz = 900.0
        case analog900MHzVoiceScramble = 900.1
        case digital900MHz = 900.2
        case dss900MHz = 900.3
        case separator3 = -1.2

        // 2.4GHz
        case analog2_4GHz = 2400.0
        case analog2_4GHzOver900MHz = 2400.900
        case digital2_4GHz = 2400.1
        case digital2_4GHzOver900MHz = 2400.901
        case dss2_4GHz = 2400.2
        case dss2_4GHzOver900MHz = 2400.902
        case fhss2_4GHz = 2400.3
        case fhss2_4GHzOver900MHz = 2400.903
        case separator4 = -1.3

        // 5.8GHz
        case analog5_8GHz = 5800.0
        case analog5_8GHzOver900MHz = 5800.900
        case analog5_8GHzOver2_4GHz = 5800.2400
        case digital5_8GHz = 5800.1
        case digital5_8GHzOver900MHz = 5800.901
        case digital5_8GHzOver2_4GHz = 5800.2401
        case dss5_8GHz = 5800.2
        case dss5_8GHzOver900MHz = 5800.902
        case dss5_8GHzOver2_4GHz = 5800.2402
        case fhss5_8GHz = 5800.3
        case fhss5_8GHzOver900MHz = 5800.903
        case fhss5_8GHzOver2_4GHz = 5800.2403
        case separator5 = -1.4

        // DECT
        case southKoreaDECT = 1786.0
        case taiwanDECT = 1880.0
        case europeAsiaAfricaOceaniaDECT = 1880.1
        case japanJDECT = 1893.0
        case brazilDECT = 1910.0
        case latinAmericaDECT = 1910.1
        case northAmericaDECT6 = 1920.0

        var id: Double { return rawValue }

        var name: String {
            switch self {
            case .separator1, .separator2, .separator3, .separator4, .separator5:
                return "Separator"
            case .unknown: return "Unknown"
                // Older Frequencies
            case .analog1_7MHz: return "1.7MHz Analog"
            case .analog30_39MHz: return "30-39MHz Analog"
            case .analog46_49MHz: return "46-49MHz Analog"
            case .analog46_49MHzVoiceScramble: return "46-49MHz Voice Scramble Analog"
                // 900MHz Frequencies
            case .analog900MHz: return "900MHz Analog/Unknown"
            case .analog900MHzVoiceScramble: return "900MHz Voice Scramble Analog"
            case .digital900MHz: return "900MHz Digital"
            case .dss900MHz: return "900MHz DSS"
                // 2.4GHz Frequencies
            case .analog2_4GHz: return "2.4GHz Analog/Unknown"
            case .analog2_4GHzOver900MHz: return "2.4GHz/900MHz Analog"
            case .digital2_4GHz: return "2.4GHz Digital"
            case .digital2_4GHzOver900MHz: return "2.4GHz/900MHz Digital"
            case .dss2_4GHz: return "2.4GHz DSS"
            case .dss2_4GHzOver900MHz: return "2.4GHz/900MHz DSS"
            case .fhss2_4GHz: return "2.4GHz FHSS"
            case .fhss2_4GHzOver900MHz: return "2.4GHz/900MHz FHSS"
                // 5.8GHz Frequencies
            case .analog5_8GHz: return "5.8GHz Analog/Unknown"
            case .analog5_8GHzOver900MHz: return "5.8GHz/900MHz Analog"
            case .analog5_8GHzOver2_4GHz: return "5.8GHz/2.4GHz Analog"
            case .digital5_8GHz: return "5.8GHz Digital"
            case .digital5_8GHzOver900MHz: return "5.8GHz/900MHz Digital"
            case .digital5_8GHzOver2_4GHz: return "5.8GHz/2.4GHz Digital"
            case .dss5_8GHz: return "5.8GHz DSS"
            case .dss5_8GHzOver900MHz: return "5.8GHz/900MHz DSS"
            case .dss5_8GHzOver2_4GHz: return "5.8GHz/2.4GHz DSS"
            case .fhss5_8GHz: return "5.8GHz Digital FHSS"
            case .fhss5_8GHzOver900MHz: return "5.8GHz/900MHz FHSS"
            case .fhss5_8GHzOver2_4GHz: return "5.8GHz/2.4GHz FHSS"
                // DECT Frequencies
            case .southKoreaDECT:
                return "DECT (1.786–1.792GHz)"
            case .taiwanDECT:
                return "DECT (1.88–1.895GHz)"
            case .europeAsiaAfricaOceaniaDECT:
                return "DECT (1.88–1.90GHz)"
            case .japanJDECT:
                return "J-DECT (1.893–1.906GHz)"
            case .brazilDECT:
                return "DECT (1.91–1.92GHz)"
            case .latinAmericaDECT:
                return "DECT (1.91–1.93GHz)"
            case .northAmericaDECT6:
                return "DECT 6.0 (1.92–1.93GHz)"
            }
        }

        static func nameFromRawValue(_ rawValue: Double) -> String {
            return (CordlessFrequency(rawValue: rawValue)?.name)!
        }

    }
}
