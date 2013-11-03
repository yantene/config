Dir.glob("{,.[^.]}**/{,.}*"){|f|
  if FileTest.file?(f) and not (f.start_with?(".git") or f.start_with?("setup.rb"))
    if f.include?("/")
      system("mkdir -p ~/" + f[0...f.index("/")])
    end
    system("ln -i -s " + File::expand_path(f) + " ~/" + f)
  end
}
