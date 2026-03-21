class Ariaflow < Formula
  desc "Sequential aria2 queue driver with adaptive bandwidth control"
  homepage "https://github.com/bonomani/ariaflow"
  url "https://github.com/bonomani/ariaflow/releases/download/v0.1.1-alpha.19/ariaflow-v0.1.1-alpha.19.tar.gz"
  sha256 "d28ef4008d9f817eba61f4c7b18f4b2055b095f7f1c7352b3f8413a9a0a3d7c3"
  version "0.1.1-alpha.18"
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
