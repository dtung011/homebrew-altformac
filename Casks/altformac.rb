# Homebrew cask for AltForMac. Lives in a tap repo named homebrew-altformac, at Casks/altformac.rb.
# Update `version` and `sha256` for every release
# (scripts/package.sh prints the sha256 of the DMG it just built).
cask "altformac" do
  version "0.1.4"
  sha256 "b2ff08eab1e86c6b0fe2eaba90e4e827c8d38480f3b33b168092558e1ebfc5ba"

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

  # macOS keeps privacy permissions after an app is deleted, so remove AltForMac's own entries
  # (Accessibility, Automation, ...) when it is uninstalled.
  uninstall quit: "dev.altformac.app"

  uninstall_postflight do
    system_command "/usr/bin/tccutil", args: ["reset", "All", "dev.altformac.app"]
  end

  zap trash: "~/Library/Application Support/AltForMac"
end
