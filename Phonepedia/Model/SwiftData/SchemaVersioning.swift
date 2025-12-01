//
//  SchemaVersioning.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 6/18/24.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftData

struct PhonepediaMigrationPlan: SchemaMigrationPlan {

    // MARK: - Properties - Schemas

    // The versioned schemas for the migration plan.
    static var schemas: [VersionedSchema.Type] = [
        PhonepediaVersionedSchemaV1.self
        // Create new versioned schemas and add them here if the data model changes between releases.
    ]

    // MARK: - Properties - Migration Stages

    static var stages: [MigrationStage] = [
        // Stages of migration between VersionedSchema, if required.
    ]

}

struct PhonepediaVersionedSchemaV1: VersionedSchema {

    // MARK: - Properties - Version

    // The version number of the schema.
    static var versionIdentifier = Schema.Version(1, 0, 0)

    // MARK: - Properties - Models

    // The models in the schema.
    static var models: [any PersistentModel.Type] = [
        Phone.self,
        CordlessHandset.self,
        CordlessHandsetCharger.self
    ]

}
