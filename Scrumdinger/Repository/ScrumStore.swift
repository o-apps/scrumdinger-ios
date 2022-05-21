//
//  ScrumStore.swift
//  Scrumdinger
//
//  Created by Rafael Orofino on 15/05/22.
//

import Foundation
import SwiftUI

class ScrumStore: ObservableObject {    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
            .appendingPathComponent("scrums.data")
    }
    
    static func load() async throws -> [DailyScrum] {
        try await withCheckedThrowingContinuation { continuation in
            DispatchQueue.global(qos: .background).async {
                do {
                    let fileURL = try fileURL()
                    
                    guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                        DispatchQueue.main.async {
                            continuation.resume(returning: [])
                        }
                        
                        return
                    }
                    
                    let dailyScrum = try JSONDecoder().decode([DailyScrum].self, from: file.availableData)
                    
                    DispatchQueue.main.async {
                        continuation.resume(returning: dailyScrum)
                    }
                } catch {
                    DispatchQueue.main.async {
                        continuation.resume(throwing: error)
                    }
                }
            }
        }
    }
    
    @discardableResult
    static func save(scrums: [DailyScrum]) async throws -> Int {
        try await withCheckedThrowingContinuation { continuation in
            DispatchQueue.global(qos: .background).async {
                do {
                    let data = try JSONEncoder().encode(scrums)
                    
                    let outFile = try fileURL()
                    
                    try data.write(to: outFile)
                    
                    DispatchQueue.main.async {
                        continuation.resume(returning: scrums.count)
                    }
                } catch {
                    DispatchQueue.main.async {
                        continuation.resume(throwing: error)
                    }
                }
            }
        }
    }
}
