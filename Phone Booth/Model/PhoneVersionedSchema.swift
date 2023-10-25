//
//  PhoneVersionedSchema.swift
//  Phone Booth
//
//  Created by Tyler Sheft on 10/25/23.
//

import Foundation
import SwiftData

enum PhoneSchemaV1: VersionedSchema {
	static var versionIdentifier = Schema.Version(1, 0, 0)

	static var models: [any PersistentModel.Type] {
		[Phone.self, CordlessHandset.self, Charger.self]
	}
}
