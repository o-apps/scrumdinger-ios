//
//  ErrorWrapper.swift
//  Scrumdinger
//
//  Created by Rafael Orofino on 15/05/22.
//

import Foundation

struct ErrorWrapper: Identifiable, Error {
    let id: UUID
    let error: Error
    let guidance: String
    
    init(id: UUID = UUID(), error: Error, guidance: String) {
        self.id = id
        self.error = error
        self.guidance = guidance
    }
}
