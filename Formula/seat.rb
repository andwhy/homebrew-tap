class Seat < Formula
  desc "Switch Claude Desktop accounts without signing in again"
  homepage "https://github.com/andwhy/claude_change_seat"
  url "https://github.com/andwhy/claude_change_seat/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "ae20ffc782ee2567f390bade2b4d54557ba246d0f2e0a801f10f77755dfaf00d"
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
