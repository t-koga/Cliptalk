# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

###
inputFile = document.querySelector("input[type='file']")

fileChange = (ev) ->
  target = ev.target
  file = target.files[0]
  type = file.type # MIMEタイプ
  size = file.size # ファイル容量（byte）
  limit = 100000 # byte 100KB
 
  # MIMEタイプの判定
  if type isnt 'image/jpeg'
    alert '選択できるファイルは10KB以下のJPEG画像だけです。'
    inputFile.value = ''
    return

  # サイズの判定
  if limit < size
    alert('10KBを超えています。10KB以下のファイルを選択してください。')
    inputFile.value = ''

inputFile.addEventListener('change', fileChange, false)
###