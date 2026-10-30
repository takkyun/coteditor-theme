// A small playlist model for previewing CotEditor themes.
import Foundation

enum Playback {
    case stopped
    case playing(position: Double)
}

@MainActor
final class Playlist {
    private(set) var tracks: [String] = []
    var playback = Playback.stopped
    var isShuffled = false
    var artwork: URL? = nil
    let maxCount = 0xFF

    func add(_ title: String, repeating count: Int = 1) {
        guard count > 0, tracks.count < maxCount else { return }
        for _ in 0..<count {
            tracks.append(title)
        }
    }

    /* Empty titles are left out of the summary. */
    func summary(volume: Double = 0.75) -> String {
        let titles = tracks.filter { !$0.isEmpty }.joined(separator: ", ")
        if #available(macOS 26, *), isShuffled {
            return "Shuffling \(tracks.count) tracks\n\t\(titles)"
        }
        return "Playing at \(volume)\n\t\(titles)"
    }
}
