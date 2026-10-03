# Beskid Homebrew formula template.
#
# Rendered by the superrepo's Woodpecker release pipeline with:
#   0.5.2  -> immutable release semver
#   8982185362c8f8ad6799edbf5304af77c4545b3e2784e0945ead43877671f387   -> sha256 of the complete darwin-arm64 target bundle
#
# The rendered file is committed to Cyber-Nomad-Collective/beskid_homebrew by
# scripts/ci/publish-homebrew-formula.sh in the superrepo. It is rendered here
# because the release assets live on beskid_compiler, not the superrepo the
# pipeline runs in.
class Beskid < Formula
  desc "Beskid compiler CLI (AOT, host composition)"
  homepage "https://beskid-lang.org"
  license "Apache-2.0"
  url "https://github.com/Cyber-Nomad-Collective/beskid_compiler/releases/download/v0.5.2/beskid-0.5.2-aarch64-apple-darwin.tar.gz"
  version "0.5.2"
  sha256 "8982185362c8f8ad6799edbf5304af77c4545b3e2784e0945ead43877671f387"

  # Apple Silicon only: the compiler pipeline builds aarch64-apple-darwin only.
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
    libexec.install "bin", "lib", "beskid_corelib", "release-version.txt"
    bin.write_exec_script libexec/"bin/beskid"
    bin.write_exec_script libexec/"bin/beskid_lsp"
    bin.write_exec_script libexec/"bin/beskid-up"
  end

  test do
    assert_match "beskid #{version}", shell_output("#{bin}/beskid --version")
  end
end
