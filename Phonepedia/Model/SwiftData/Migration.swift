//
//  Migration.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 6/18/24.
//  Copyright © 2023-2024 SheftApps. All rights reserved.
//

import SwiftData

struct PhonepediaMigrationPlan: SchemaMigrationPlan {
    static var schemas: [VersionedSchema.Type] = [
        PhonepediaVersionedSchema.self,
    ]

    static var stages: [MigrationStage] = [
        // Stages of migration between VersionedSchema, if required.
    ]
}

struct PhonepediaVersionedSchema: VersionedSchema {
    static var versionIdentifier = Schema.Version(1, 0, 0)

    static var models: [any PersistentModel.Type] = [
        Phone.self,
        CordlessHandset.self,
        Charger.self
    ]
}
