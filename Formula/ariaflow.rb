class Ariaflow < Formula
  desc "Sequential aria2 queue driver with adaptive bandwidth control"
  homepage "https://github.com/bonomani/ariaflow"
  url "https://github.com/bonomani/ariaflow/releases/download/v0.1.1-alpha.13/ariaflow-v0.1.1-alpha.13.tar.gz"
  sha256 "1bf618da8f1d4ef532c2e2edc1fa1c857cfa8ed033e555e5473c7eb4eeffbf6a"
  version "0.1.1-alpha.13"
  license "MIT"
  head "https://github.com/bonomani/ariaflow.git", branch: "master"

  depends_on "python@3.12"

  def install
    libexec.install "src"

    (bin/"ariaflow").write <<~EOS
      #!/bin/bash
      export PYTHONPATH="\#{libexec}/src:${PYTHONPATH}"
      exec "\#{Formula["python@3.12"].opt_bin}/python3" -m aria_queue "$@"
    EOS
    chmod 0755, bin/"ariaflow"
  end

  test do
    system bin/"ariaflow", "--help"
  end
end
