# Beskid Homebrew formula template.
#
# Rendered by the macos-brew CI job with:
#   0.4.363  -> immutable release semver
#   22563802b5f47c7f89ca561ecb881337d937981f3dc29a75c280464c440e12fd   -> sha256 of the darwin-arm64 CLI release asset
#
# The rendered file is committed to Cyber-Nomad-Collective/beskid_homebrew
# by Justintime50/homebrew-releaser. We render it ourselves (rather than letting
# the action do it) because the release assets live on beskid_compiler, not the
# superrepo the workflow runs in.
class Beskid < Formula
  desc "Beskid compiler CLI (AOT, host composition)"
  homepage "https://beskid-lang.org"
  url "https://github.com/Cyber-Nomad-Collective/beskid_compiler/releases/download/cli-v0.4.363/beskid-darwin-arm64"
  version "0.4.363"
  sha256 "22563802b5f47c7f89ca561ecb881337d937981f3dc29a75c280464c440e12fd"

  # Apple Silicon only in v1 (compiler.yml builds aarch64-apple-darwin only).
  on_macos do
    on_arm do
      # nothing extra; binary is prebuilt for arm64
    end
    on_intel do
      # No Intel build in v1. Disable cleanly so `brew install` on Intel fails
      # with a clear message rather than a confusing binary error.
      depends_on arch: :arm
    end
  end

  def install
    # The release asset is a bare Mach-O binary named beskid-darwin-arm64.
    bin.install "beskid-darwin-arm64" => "beskid"
  end

  test do
    assert_match "beskid #{version}", shell_output("#{bin}/beskid --version")
  end
end
