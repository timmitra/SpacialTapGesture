//
// ---------------------------- //
// Original Project: SpacialTapGesture
// Created on 2024-11-06 by Tim Mitra
// Mastodon: @timmitra@mastodon.social
// Twitter/X: timmitra@twitter.com
// Web site: https://www.it-guy.com
// ---------------------------- //
// Copyright © 2024 iT Guy Technologies. All rights reserved.


import SwiftUI

/// Maintains app-wide state
@MainActor
@Observable
class AppModel {
    let immersiveSpaceID = "ImmersiveSpace"
    enum ImmersiveSpaceState {
        case closed
        case inTransition
        case open
    }
    var immersiveSpaceState = ImmersiveSpaceState.closed
}
