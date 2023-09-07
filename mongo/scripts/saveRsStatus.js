var status = rs.status();
var jsonStr = JSON.stringify(status, null, 2);  // 2 boşluk ile girinti yaparak okunabilir bir JSON formatında döndürür.
writeFile("/path/to/crt/repl_status.json", jsonStr);