class AriaflowWeb < Formula
  desc "Local dashboard frontend for ariaflow"
  homepage "https://github.com/bonomani/ariaflow-web"
  url "https://github.com/bonomani/ariaflow-web/archive/refs/tags/v0.1.203.tar.gz"
  sha256 "336a625f90f7364cdf6128ffba27f0bf9ae3d21a1b70b7162007f9552756b1e3"
  version "0.1.203"
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
