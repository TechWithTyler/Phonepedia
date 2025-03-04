//
//  CordlessFrequency.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 1/24/25.
//  Copyright © 2025 SheftApps. All rights reserved.
//

import Foundation

extension Phone {

    enum CordlessFrequency: Double, CaseIterable, Identifiable {

        // MARK: - Frequency Cases

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

        // MARK: - Properties - ID

        var id: Double { return rawValue }

        // MARK: - Properties - Strings

        var name: String {
            switch self {
            case .separator1, .separator2, .separator3, .separator4, .separator5:
                return "Separator"
            case .unknown: return "Unknown"
                // Older Frequencies
            case .analog1_7MHz: return "1.7MHz Analog"
            case .analog30_39MHz: return "30-39MHz Analog"
            case .analog46_49MHz: return "46-49MHz Analog"
            case .analog46_49MHzVoiceScramble: return "46-49MHz Voice Scramble"
                // 900MHz Frequencies
            case .analog900MHz: return "900MHz Analog/Unknown"
            case .analog900MHzVoiceScramble: return "900MHz Voice Scramble"
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
                return "South Korea DECT"
            case .taiwanDECT:
                return "Taiwan DECT"
            case .europeAsiaAfricaOceaniaDECT:
                return "ETSI DECT"
            case .japanJDECT:
                return "Japan J-DECT"
            case .brazilDECT:
                return "Brazil DECT"
            case .latinAmericaDECT:
                return "Latin America DECT"
            case .northAmericaDECT6:
                return "North America DECT 6.0"
            }
        }

        var waveName: String {
            switch self {
            case .analog1_7MHz:
                return "1.7MHz"
            case .analog30_39MHz:
                return "30-39MHz"
            case .analog46_49MHz:
                return "46-49MHz"
            case .analog900MHz:
                return "900MHz"
            case .analog2_4GHz:
                return "2.4GHz"
            case .analog5_8GHz:
                return "5.8GHz"
            case .southKoreaDECT, .taiwanDECT, .europeAsiaAfricaOceaniaDECT, .japanJDECT, .brazilDECT, .latinAmericaDECT, .northAmericaDECT6:
                return name
            default: return String()
            }
        }

        // MARK: - Properties - Doubles

        var waveFrequency: Double {
            switch self {
            case .analog1_7MHz:
                return 1.7
            case .analog30_39MHz:
                return 30
            case .analog46_49MHz:
                return 46
            case .analog900MHz:
                return 902
            case .analog2_4GHz:
                return 2400
            case .analog5_8GHz:
                return 5800
            case .southKoreaDECT:
                return 1786
            case .taiwanDECT:
                return 1880
            case .europeAsiaAfricaOceaniaDECT:
                return 1890
            case .japanJDECT:
                return 1893
            case .brazilDECT:
                return 1910
            case .latinAmericaDECT:
                return 1920
            case .northAmericaDECT6:
                return 1930
            default: return 0
            }
        }

        // MARK: - Properties - Default Frequency for Current Region

        // Returns the default cordless phone frequency for the current region based on the device's region setting.
        static var defaultForCurrentRegion: CordlessFrequency {
            switch Locale.current.region?.identifier {
            case "KR":
                // South Korea
                return .southKoreaDECT
            case "TW":
                // Taiwan
                return .taiwanDECT
            case "JP":
                // Japan
                return .japanJDECT
            case "BR":
                // Brazil
                return .brazilDECT
            case "US":
                // United States
                return .northAmericaDECT6
            case "CA":
                // Canada
                return .northAmericaDECT6
            case "MX":
                // Mexico
                return .northAmericaDECT6
            case "VI":
                // Virgin Islands
                return .northAmericaDECT6
            case "PR":
                // Puerto Rico
                return .northAmericaDECT6
            case "GU":
                // Guam
                return .northAmericaDECT6
            case "MP":
                // Northern Mariana Islands
                return .northAmericaDECT6
            case "AS":
                // American Samoa
                return .northAmericaDECT6
            case "AR":
                // Argentina
                return .latinAmericaDECT
            case "CL":
                // Chile
                return .latinAmericaDECT
            case "CO":
                // Colombia
                return .latinAmericaDECT
            case "PE":
                // Peru
                return .latinAmericaDECT
            case "EC":
                // Ecuador
                return .latinAmericaDECT
            case "UY":
                // Uruguay
                return .latinAmericaDECT
            case "PY":
                // Paraguay
                return .latinAmericaDECT
            case "BO":
                // Bolivia
                return .latinAmericaDECT
            case "VE":
                // Venezuela
                return .latinAmericaDECT
            case "CR":
                // Costa Rica
                return .latinAmericaDECT
            case "PA":
                // Panama
                return .latinAmericaDECT
            case "SV":
                // El Salvador
                return .latinAmericaDECT
            case "GT":
                // Guatemala
                return .latinAmericaDECT
            case "HN":
                // Honduras
                return .latinAmericaDECT
            case "NI":
                // Nicaragua
                return .latinAmericaDECT
            case "DO":
                // Dominican Republic
                return .latinAmericaDECT
            case "GB":
                // United Kingdom
                return .europeAsiaAfricaOceaniaDECT
            case "FR":
                // France
                return .europeAsiaAfricaOceaniaDECT
            case "DE":
                // Germany
                return .europeAsiaAfricaOceaniaDECT
            case "AU":
                // Australia
                return .europeAsiaAfricaOceaniaDECT
            case "IN":
                // India
                return .europeAsiaAfricaOceaniaDECT
            case "IT":
                // Italy
                return .europeAsiaAfricaOceaniaDECT
            case "ES":
                // Spain
                return .europeAsiaAfricaOceaniaDECT
            case "NL":
                // Netherlands
                return .europeAsiaAfricaOceaniaDECT
            case "SE":
                // Sweden
                return .europeAsiaAfricaOceaniaDECT
            case "NO":
                // Norway
                return .europeAsiaAfricaOceaniaDECT
            case "DK":
                // Denmark
                return .europeAsiaAfricaOceaniaDECT
            case "FI":
                // Finland
                return .europeAsiaAfricaOceaniaDECT
            case "BE":
                // Belgium
                return .europeAsiaAfricaOceaniaDECT
            case "CH":
                // Switzerland
                return .europeAsiaAfricaOceaniaDECT
            case "AT":
                // Austria
                return .europeAsiaAfricaOceaniaDECT
            case "IE":
                // Ireland
                return .europeAsiaAfricaOceaniaDECT
            case "NZ":
                // New Zealand
                return .europeAsiaAfricaOceaniaDECT
            case "SG":
                // Singapore
                return .europeAsiaAfricaOceaniaDECT
            case "MY":
                // Malaysia
                return .europeAsiaAfricaOceaniaDECT
            case "ZA":
                // South Africa
                return .europeAsiaAfricaOceaniaDECT
            case "PT":
                // Portugal
                return .europeAsiaAfricaOceaniaDECT
            case "GR":
                // Greece
                return .europeAsiaAfricaOceaniaDECT
            case "CZ":
                // Czech Republic
                return .europeAsiaAfricaOceaniaDECT
            case "PL":
                // Poland
                return .europeAsiaAfricaOceaniaDECT
            case "HU":
                // Hungary
                return .europeAsiaAfricaOceaniaDECT
            case "RO":
                // Romania
                return .europeAsiaAfricaOceaniaDECT
            case "SK":
                // Slovakia
                return .europeAsiaAfricaOceaniaDECT
            case "SI":
                // Slovenia
                return .europeAsiaAfricaOceaniaDECT
            case "EE":
                // Estonia
                return .europeAsiaAfricaOceaniaDECT
            case "LV":
                // Latvia
                return .europeAsiaAfricaOceaniaDECT
            case "LT":
                // Lithuania
                return .europeAsiaAfricaOceaniaDECT
            case "BG":
                // Bulgaria
                return .europeAsiaAfricaOceaniaDECT
            case "HR":
                // Croatia
                return .europeAsiaAfricaOceaniaDECT
            case "CY":
                // Cyprus
                return .europeAsiaAfricaOceaniaDECT
            case "MT":
                // Malta
                return .europeAsiaAfricaOceaniaDECT
            case "IS":
                // Iceland
                return .europeAsiaAfricaOceaniaDECT
            case "LU":
                // Luxembourg
                return .europeAsiaAfricaOceaniaDECT
            case "LI":
                // Liechtenstein
                return .europeAsiaAfricaOceaniaDECT
            case "RU":
                // Russia
                return .europeAsiaAfricaOceaniaDECT
            case "UA":
                // Ukraine
                return .europeAsiaAfricaOceaniaDECT
            case "BY":
                // Belarus
                return .europeAsiaAfricaOceaniaDECT
            case "KZ":
                // Kazakhstan
                return .europeAsiaAfricaOceaniaDECT
            case "MD":
                // Moldova
                return .europeAsiaAfricaOceaniaDECT
            case "GE":
                // Georgia
                return .europeAsiaAfricaOceaniaDECT
            case "AM":
                // Armenia
                return .europeAsiaAfricaOceaniaDECT
            case "AZ":
                // Azerbaijan
                return .europeAsiaAfricaOceaniaDECT
            case "SA":
                // Saudi Arabia
                return .europeAsiaAfricaOceaniaDECT
            case "AE":
                // United Arab Emirates
                return .europeAsiaAfricaOceaniaDECT
            case "QA":
                // Qatar
                return .europeAsiaAfricaOceaniaDECT
            case "KW":
                // Kuwait
                return .europeAsiaAfricaOceaniaDECT
            case "BH":
                // Bahrain
                return .europeAsiaAfricaOceaniaDECT
            case "OM":
                // Oman
                return .europeAsiaAfricaOceaniaDECT
            case "EG":
                // Egypt
                return .europeAsiaAfricaOceaniaDECT
            case "JO":
                // Jordan
                return .europeAsiaAfricaOceaniaDECT
            case "LB":
                // Lebanon
                return .europeAsiaAfricaOceaniaDECT
            case "MA":
                // Morocco
                return .europeAsiaAfricaOceaniaDECT
            case "DZ":
                // Algeria
                return .europeAsiaAfricaOceaniaDECT
            case "TN":
                // Tunisia
                return .europeAsiaAfricaOceaniaDECT
            case "LY":
                // Libya
                return .europeAsiaAfricaOceaniaDECT
            case "CN":
                // China
                return .europeAsiaAfricaOceaniaDECT
            case "HK":
                // Hong Kong
                return .europeAsiaAfricaOceaniaDECT
            case "MO":
                // Macau
                return .europeAsiaAfricaOceaniaDECT
            default:
                return .unknown // Unknown region/unknown default cordless phone frequency for current region
            }
        }

        // MARK: - Frequency Name From Raw Value

        static func nameFromRawValue(_ rawValue: Double) -> String {
            return (CordlessFrequency(rawValue: rawValue)?.name)!
        }

    }
}
