class Ariaflow < Formula
  desc "Sequential aria2 queue driver with adaptive bandwidth control"
  homepage "https://github.com/bonomani/ariaflow"
  url "https://github.com/bonomani/ariaflow/releases/download/v0.1.1-alpha.23/ariaflow-v0.1.1-alpha.23.tar.gz"
  sha256 "435f9f827f3b33a9e6694aa2b7fb06404ec6ad85e1ac0c22b5ebdfb40a1915c5"
  version "0.1.1-alpha.23"
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
