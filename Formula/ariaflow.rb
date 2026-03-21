class Ariaflow < Formula
  desc "Sequential aria2 queue driver with adaptive bandwidth control"
  homepage "https://github.com/bonomani/ariaflow"
  url "https://github.com/bonomani/ariaflow/archive/refs/tags/v0.1.1-alpha.34.tar.gz"
  sha256 "12eb4009f7d63793c205b1ea08cf345acfd3421999c865394775ac29bec7a6b2"
  version "0.1.1-alpha.34"
  license "MIT"
  head "https://github.com/bonomani/ariaflow.git", branch: "master"

  def install
    libexec.install "src"

    (bin/"ariaflow").write <<~EOS
      #!/bin/bash
      exec env PYTHONPATH="#{libexec}/src:${PYTHONPATH}" python3 -m aria_queue "$@"
    EOS
    chmod 0755, bin/"ariaflow"
  end

  service do
    run [opt_bin/"ariaflow", "serve", "--host", "127.0.0.1", "--port", "8000"]
    keep_alive true
    working_dir var
    log_path var/"log/ariaflow.log"
    error_log_path var/"log/ariaflow.err.log"
  end

  plist do
    <<~PLIST
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
        <key>Label</key>
        <string>homebrew.mxcl.ariaflow</string>
        <key>ProgramArguments</key>
        <array>
          <string>#{opt_bin}/ariaflow</string>
          <string>serve</string>
          <string>--host</string>
          <string>127.0.0.1</string>
          <string>--port</string>
          <string>8000</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
        <key>KeepAlive</key>
        <true/>
        <key>WorkingDirectory</key>
        <string>#{var}</string>
        <key>StandardOutPath</key>
        <string>#{var}/log/ariaflow.log</string>
        <key>StandardErrorPath</key>
        <string>#{var}/log/ariaflow.err.log</string>
      </dict>
      </plist>
    PLIST
  end

  test do
    system bin/"ariaflow", "--help"
  end
end
