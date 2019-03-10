function avatarChange(ev) {
  var file, limit, size, type;
  file = ev.files[0];
  type = file.type; // MIMEタイプ
  size = file.size; // ファイル容量（byte）
  limit = 100000; // byte 100KB
  
  // MIMEタイプの判定
  if (type !== 'image/jpg' && type !== 'image/jpeg' && type !== 'image/png' && type !== 'image/gif') {
    alert('選択できる画像ファイルは jpg,jpeg,png,gif のみです。');
    ev.value = '';
    return;
  }
  // サイズの判定
  if (limit < size) {
    alert('100KBを超えています。100KB以下のファイルを選択してください。');
    ev.value = '';
    return;
  }
}
