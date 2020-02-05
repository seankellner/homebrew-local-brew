class YqAT2 < Formula
  desc "yq is a portable command-line YAML processor"
  homepage "https://mikefarah.gitbook.io/yq/"
  url "https://github.com/mikefarah/yq/archive/v2.4.1.tar.gz"
  sha256 "11fdf8269eb9eecd47398cb0d269a775492881ef53d880ef0d0e0daee26490d2"

  depends_on "go" => :build

  conflicts_with "python-yq", :because => "both install `yq` executables"

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/mikefarah/yq").install buildpath.children

    cd "src/github.com/mikefarah/yq" do
      system "go", "build", "-o", bin/"yq"
      prefix.install_metafiles
    end
  end

  test do
    assert_equal "key: cat", shell_output("#{bin}/yq n key cat").chomp
    assert_equal "cat", pipe_output("#{bin}/yq r - key", "key: cat", 0).chomp
  end
end
