//
//  PhoneVersionedSchema.swift
//  Phone Booth
//
//  Created by Tyler Sheft on 10/25/23.
//

import Foundation
import SwiftData

typealias Phone = PhoneSchemaV1.Phone

typealias CordlessHandset = PhoneSchemaV1.CordlessHandset

typealias Charger = PhoneSchemaV1.Charger

enum PhoneSchemaV1: VersionedSchema {
	static var versionIdentifier = Schema.Version(1, 0, 0)

	static var models: [any PersistentModel.Type] {
		[Phone.self, CordlessHandset.self, Charger.self]
	}
}
