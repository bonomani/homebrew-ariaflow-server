class Ariaflow < Formula
  desc "Sequential aria2 queue driver with adaptive bandwidth control"
  homepage "https://github.com/bonomani/ariaflow"
  url "https://github.com/bonomani/ariaflow/archive/refs/tags/v0.1.1-alpha.9.tar.gz"
  sha256 "407678dd4b4dec386da210196bf19a92856baaf8ecf983dc7bfb1c6a55d8ce17"
  version "0.1.1-alpha.9"
  license "MIT"
  head "https://github.com/bonomani/ariaflow.git", branch: "master"

  depends_on "python3"

  def install
    libexec.install "src"

    (bin/"ariaflow").write <<~EOS
      #!/bin/bash
      export PYTHONPATH="#{libexec}/src:${PYTHONPATH}"
      exec "#{Formula["python3"].opt_bin}/python3" -m aria_queue "$@"
    EOS
    chmod 0755, bin/"ariaflow"
  end

  test do
    system bin/"ariaflow", "--help"
  end
end
