// init-mongo.js

// SCRAM user
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

db.getSiblingDB("$external").runCommand(
  {
    createUser: "/C=TR/ST=Istanbul/L=Istanbul/OU=MyMongoDBCluster,O=MyMongoDBCompany/CN=localhost",
    roles: [
         { role: "readWrite", db: "items" },
         { role: "userAdminAnyDatabase", db: "admin" }
    ],
    writeConcern: { w: "majority" , wtimeout: 5000 }
  }
)


