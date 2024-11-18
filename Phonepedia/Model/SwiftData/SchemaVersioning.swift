//
//  SchemaVersioning.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 6/18/24.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftData

struct PhonepediaMigrationPlan: SchemaMigrationPlan {

    // The versioned schemas for the migration plan.
    static var schemas: [VersionedSchema.Type] = [
        PhonepediaVersionedSchemaV1.self
        // Create new versioned schemas and add them here if the data model changes between releases.
    ]

    static var stages: [MigrationStage] = [
        // Stages of migration between VersionedSchema, if required.
    ]

}

struct PhonepediaVersionedSchemaV1: VersionedSchema {

    // The version number of the schema.
    static var versionIdentifier = Schema.Version(1, 0, 0)

    // The models in the schema.
    static var models: [any PersistentModel.Type] = [
        Phone.self,
        CordlessHandset.self,
        CordlessHandsetCharger.self
    ]

}
