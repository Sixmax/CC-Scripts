if not http then
    print('HTTP is not enabled.')
    return
  end
   
  local script = ""
   
  loadstring((http.get("http://www.pastebin.com/raw.php?i=" .. script)).readAll())()