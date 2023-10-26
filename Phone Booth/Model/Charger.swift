//
//  Charger.swift
//  Phone Booth
//
//  Created by Tyler Sheft on 6/28/23.
//  Copyright © 2023 SheftApps. All rights reserved.
//

import Foundation
import SwiftData

	@Model
	final class Charger {

		var phone: Phone?

		var color: String

		var chargingDirection: Int = 0

		var chargeContactPlacement: Int = 0

		var chargeContactMechanism: Int = 1

		var hasRangeExtender: Bool = false

		var wallMountability: Int = 0

		init(color: String) {
			self.color = color
		}

	}
