class Ariaflow < Formula
  desc "Sequential aria2 queue driver with adaptive bandwidth control"
  homepage "https://github.com/bonomani/ariaflow"
  url "https://github.com/bonomani/ariaflow/archive/refs/tags/v0.1.1-alpha.26.tar.gz"
  sha256 "c24db60cdcd4adfdc607eefb5fec13e2386e8c07dd0327b189921d8d5af81d49"
  version "0.1.1-alpha.26"
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
