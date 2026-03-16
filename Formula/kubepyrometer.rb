# Homebrew formula for KubePyrometer
# Install:
#   brew tap spectronauts/kubepyrometer
#   brew install kubepyrometer

class Kubepyrometer < Formula
  desc "Kubernetes control-plane load-testing harness"
  homepage "https://github.com/spectronauts/KubePyrometer"
  url "https://github.com/spectronauts/KubePyrometer/releases/download/v1.1.1/kubepyrometer-1.1.1.tar.gz"
  sha256 "8cd3c22f6f92233b9b057249be3b86a11bc21aa27015eba696663b57db229683"
  license "Apache-2.0"

  depends_on "bash"
  depends_on "kubectl" => :recommended

  def install
    kp = libexec/"kubepyrometer"
    kp.install Dir["lib/scripts", "lib/workloads", "lib/templates",
                   "lib/manifests", "lib/configs", "lib/images",
                   "lib/config.yaml", "lib/run.sh"]
    kp.install "VERSION"

    bin.install "kubepyrometer"
  end

  def caveats
    <<~EOS
      To get started:
        kubepyrometer init           # generate a config file in the current directory
        kubepyrometer run            # run with default settings
        kubepyrometer run -p large   # run with the 'large' cluster profile

      Run output is saved to ./runs/<timestamp>/ by default.
      See kubepyrometer help for all commands.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/kubepyrometer version")
  end
end
