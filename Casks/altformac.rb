# Homebrew cask for AltForMac. Lives in a tap repo named homebrew-altformac, at Casks/altformac.rb.
# Update `version` and `sha256` for every release
# (scripts/package.sh prints the sha256 of the DMG it just built).
cask "altformac" do
  version "0.1.1"
  sha256 "28098c210175e8e255f5ed99689ec7b59a411b8a417a25a43afa4008e04ac4f4"

  url "https://github.com/dtung011/altformac/releases/download/v#{version}/AltForMac-#{version}.dmg"
  name "AltForMac"
  desc "Windows-style Alt key sequences for Excel, Word and PowerPoint on Mac"
  homepage "https://github.com/dtung011/altformac"

  depends_on macos: ">= :ventura"
  depends_on arch: :arm64 # remove once the DMG is a universal build

  app "AltForMac.app"

  # The app is not notarized yet, so Gatekeeper would block the first launch. Delete this block once
  # the DMG is signed with a Developer ID and notarized (see scripts/package.sh).
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/AltForMac.app"]
  end

  zap trash: "~/Library/Application Support/AltForMac"
end
