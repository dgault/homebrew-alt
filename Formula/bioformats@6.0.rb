class BioformatsAT60 < Formula
  desc "Library for reading proprietary image file formats"
  homepage "https://www.openmicroscopy.org/site/products/bio-formats"
  url "https://downloads.openmicroscopy.org/bio-formats/6.0.1/artifacts/bioformats-6.0.1.zip"
  sha256 "dd4a258e5eff9e93e0026f87da91745acf57de6d9a94edc6cd8c8fb2fbef89d6"

  depends_on "ant" => :build

  def install
    # Build libraries
    args = ["ant", "clean", "tools", "-Dmaven.repo.local",
            "#{buildpath}/.m2/repository"]
    system *args

    # Remove Windows files
    rm Dir["tools/*.bat"]

    # Copy artifacts
    libexec.install "artifacts/bioformats_package.jar"

    # Copy command line-tools
    libexec.install Dir["tools/*"]

    %w[bfconvert domainlist formatlist ijview mkfake omeul showinf tiffcomment xmlindent xmlvalid].each do |fn|
      bin.install_symlink libexec/fn
    end
  end
  test do
    system "showinf", "-version"
    system "bfconvert", "-version"
  end
end
