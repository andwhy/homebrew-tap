class Seat < Formula
  desc "Switch Claude Desktop accounts without signing in again"
  homepage "https://github.com/andwhy/claude_change_seat"
  url "https://github.com/andwhy/claude_change_seat/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "0eb1d36ec91b158be9efb376fa7b682dbcd225767cf6d6c3d35a2c9285398f8d"
  license "MIT"
  head "https://github.com/andwhy/claude_change_seat.git", branch: "main"

  depends_on :macos

  def install
    bin.install "seat"
  end

  test do
    assert_equal "seat #{version}", shell_output("#{bin}/seat --version").chomp

    ENV["SEAT_LIVE_DIR"] = (testpath/"live").to_s
    ENV["SEAT_STORE_DIR"] = (testpath/"store").to_s
    ENV["SEAT_APP_NAME"] = "seat-test-no-such-app"
    (testpath/"live").mkpath
    system bin/"seat", "add", "work"
    assert_equal "work", (testpath/"store/work/.seat-profile").read.chomp
    assert_equal "default", shell_output("#{bin}/seat current").chomp
  end
end
