class AriaflowServer < Formula
  desc "Sequential aria2 queue driver with adaptive bandwidth control"
  homepage "https://github.com/bonomani/ariaflow-server"
  url "https://github.com/bonomani/ariaflow-server/archive/refs/tags/v0.1.165.tar.gz"
  sha256 "9abf03f4cd95bb9d5694cefbce4115ea4b8e3514bef7885da87daeefe1826390"
  version "0.1.165"
  license "MIT"
  depends_on "python"
  depends_on "aria2"
  head "https://github.com/bonomani/ariaflow-server.git", branch: "main"

  def install
    libexec.install "src"

    (bin/"ariaflow-server").write <<~EOS
      #!/bin/bash
      exec env PYTHONPATH="#{libexec}/src:${PYTHONPATH}" python3 -m ariaflow_server "$@"
    EOS
    chmod 0755, bin/"ariaflow-server"
  end

  service do
    run [opt_bin/"ariaflow-server", "serve", "--host", "127.0.0.1", "--port", "8000"]
    keep_alive true
    working_dir var
    log_path var/"log/ariaflow-server.log"
    error_log_path var/"log/ariaflow-server.err.log"
  end

  test do
    system bin/"ariaflow-server", "--help"
  end
end
