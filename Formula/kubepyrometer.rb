# Homebrew formula for KubePyrometer
# Install:
#   brew tap spectronauts/kubepyrometer
#   brew install kubepyrometer

class Kubepyrometer < Formula
  desc "Kubernetes control-plane load-testing harness"
  homepage "https://github.com/spectronauts/KubePyrometer"
  url "https://github.com/spectronauts/KubePyrometer/releases/download/v1.2.0/kubepyrometer-1.2.0.tar.gz"
  sha256 "36a82093438398643eed3d7b8f0a1d361b61bfa04ea06e1cfa224ad1cd751764"
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
