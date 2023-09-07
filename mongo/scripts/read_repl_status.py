import json

# JSON dosyasını oku
with open('repl_status.json', 'r') as file:
    data = json.load(file)

# Eğer JSON dosyası rs.status() çıktısına uygunsa
if 'members' in data:
    for member in data['members']:
        print(f"Host: {member['name']}, Optime: {member['optime']}")

else:
    print("JSON dosyası uygun formatte değil.")