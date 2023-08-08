// init-mongo.js

db.getSiblingDB('admin').createUser(
  {
    user: "myUserAdmin",
    pwd: "1234", 
    roles: [
      { role: "userAdminAnyDatabase", db: "admin" },
      { role: "readWriteAnyDatabase", db: "admin" }
    ]
  }
)

// test adında bir database oluştur
db = db.getSiblingDB('test');

// items adında bir collection oluştur ve içine bazı test verileri ekleyin
db.items.insert([
    { name: "item1", description: "This is item 1" },
    { name: "item2", description: "This is item 2" },
    { name: "item3", description: "This is item 3" }
]);

print("Test data inserted.");
