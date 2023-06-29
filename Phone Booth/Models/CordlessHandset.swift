//
//  CordlessHandset.swift
//  Phone Booth
//
//  Created by Tyler Sheft on 6/28/23.
//

import Foundation
import SwiftData

@Model
final class CordlessHandset {

	var phone: Phone?

	var model: String

	var color: String

	init(model: String, color: String) {
		self.model = model
		self.color = color
	}

}
