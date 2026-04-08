class AriaflowWeb < Formula
  desc "Local dashboard frontend for ariaflow"
  homepage "https://github.com/bonomani/ariaflow-web"
  url "https://github.com/bonomani/ariaflow-web/archive/refs/tags/v0.1.250.tar.gz"
  sha256 "2b276c26766a8001459b08b5ef974378f5e213a7d8fd8e8296dd2e41cad0e2b5"
  version "0.1.250"
  license "MIT"
  depends_on "python"
  depends_on "ariaflow"
  head "https://github.com/bonomani/ariaflow-web.git", branch: "main"

  def install
    libexec.install "src"

    (bin/"ariaflow-web").write <<~EOS
      #!/bin/bash
      exec env PYTHONPATH="#{libexec}/src:${PYTHONPATH}" python3 -m ariaflow_web.cli "$@"
    EOS
    chmod 0755, bin/"ariaflow-web"
  end

  service do
    environment_variables ARIAFLOW_API_URL: "http://127.0.0.1:8000"
    run [opt_bin/"ariaflow-web", "--host", "127.0.0.1", "--port", "8001"]
    keep_alive true
    working_dir var
    log_path var/"log/ariaflow-web.log"
    error_log_path var/"log/ariaflow-web.err.log"
  end

  test do
    system bin/"ariaflow-web", "--version"
  end
end
