class Ariaflow < Formula
  desc "Sequential aria2 queue driver with adaptive bandwidth control"
  homepage "https://github.com/bonomani/ariaflow"
  url "https://github.com/bonomani/ariaflow/archive/refs/tags/v0.1.1-alpha.30.tar.gz"
  sha256 "ef1183777eaf69892d9467e1a480837683c7fae90251523ee1b13e1e2a72192b"
  version "0.1.1-alpha.30"
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

  test do
    system bin/"ariaflow", "--help"
  end
end
