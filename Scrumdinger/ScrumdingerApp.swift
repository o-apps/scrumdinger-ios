//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by Rafael Orofino on 09/05/22.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    @StateObject private var store = ScrumStore()
    @State private var scrums: [DailyScrum] = []
    @State private var errorWrapper: ErrorWrapper?
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ScrumsView(scrums: $scrums) {
                    Task {
                        do {
                            try await ScrumStore.save(scrums: self.scrums)
                        } catch {
                            self.errorWrapper = ErrorWrapper(error: error, guidance: "Try again later.")
                        }
                    }
                }
            }
            .task {
                do {
                    self.scrums = try await ScrumStore.load()
                } catch {
                    self.errorWrapper = ErrorWrapper(error: error, guidance: "Scrumdinger will load sample data and continue.")
                }
            }
            .sheet(item: $errorWrapper, onDismiss: {
                self.scrums = DailyScrum.sampleData
            }) { wrapper in
                ErrorView(errorWrapper: wrapper)
            }
        }
    }
}
