# В базе данных Redis подберите коллекцию для подсчета посещений с определенных IP-адресов.
# При помощи базы данных Redis решите задачу поиска имени пользователя по электронному адресу и наоборот, поиск электронного адреса пользователя по его имени.

# сделал в файлах 2.[sh, js]

# Организуйте хранение категорий и товарных позиций учебной базы данных shop в СУБД MongoDB.

/*
db.getCollection("catalogs").drop();
db.createCollection("catalogs");
db.getCollection("catalogs").createIndex({
    id: NumberInt("1")
}, {
    name: "id",
    unique: true
});
db.getCollection("catalogs").createIndex({
    name: NumberInt("1")
}, {
    name: "unique_name",
    unique: true
});

db.getCollection("catalogs").insert([ {
    _id: ObjectId("62649fc27d460000c9002245"),
    id: NumberLong("1"),
    name: "Процессоры"
} ]);
db.getCollection("catalogs").insert([ {
    _id: ObjectId("62649fc27d460000c9002246"),
    id: NumberLong("2"),
    name: "Материнские платы"
} ]);
db.getCollection("catalogs").insert([ {
    _id: ObjectId("62649fc27d460000c9002247"),
    id: NumberLong("3"),
    name: "Видеокарты"
} ]);
db.getCollection("catalogs").insert([ {
    _id: ObjectId("62649fc27d460000c9002248"),
    id: NumberLong("4"),
    name: "Жесткие диски"
} ]);
db.getCollection("catalogs").insert([ {
    _id: ObjectId("62649fc27d460000c9002249"),
    id: NumberLong("5"),
    name: "Оперативная память"
} ]);

db.getCollection("products").drop();
db.createCollection("products");
db.getCollection("products").createIndex({
    id: NumberInt("1")
}, {
    name: "id",
    unique: true
});
db.getCollection("products").createIndex({
    "catalog_id": NumberInt("1")
}, {
    name: "index_of_catalog_id"
});

db.getCollection("products").insert([ {
    _id: ObjectId("62649fc27d460000c900224a"),
    id: NumberLong("1"),
    name: "Intel Core i3-8100",
    description: "Процессор для настольных персональных компьютеров, основанных на платформе Intel.",
    price: 7890,
    "catalog_id": NumberInt("1"),
    "created_at": ISODate("2022-04-24T05:51:08.000Z"),
    "updated_at": ISODate("2022-04-24T05:51:08.000Z")
} ]);
db.getCollection("products").insert([ {
    _id: ObjectId("62649fc27d460000c900224b"),
    id: NumberLong("2"),
    name: "Intel Core i5-7400",
    description: "Процессор для настольных персональных компьютеров, основанных на платформе Intel.",
    price: 12700,
    "catalog_id": NumberInt("1"),
    "created_at": ISODate("2022-04-24T05:51:08.000Z"),
    "updated_at": ISODate("2022-04-24T05:51:08.000Z")
} ]);
db.getCollection("products").insert([ {
    _id: ObjectId("62649fc27d460000c900224c"),
    id: NumberLong("3"),
    name: "AMD FX-8320E",
    description: "Процессор для настольных персональных компьютеров, основанных на платформе AMD.",
    price: 4780,
    "catalog_id": NumberInt("1"),
    "created_at": ISODate("2022-04-24T05:51:08.000Z"),
    "updated_at": ISODate("2022-04-24T05:51:08.000Z")
} ]);
db.getCollection("products").insert([ {
    _id: ObjectId("62649fc27d460000c900224d"),
    id: NumberLong("4"),
    name: "AMD FX-8320",
    description: "Процессор для настольных персональных компьютеров, основанных на платформе AMD.",
    price: 7120,
    "catalog_id": NumberInt("1"),
    "created_at": ISODate("2022-04-24T05:51:08.000Z"),
    "updated_at": ISODate("2022-04-24T05:51:08.000Z")
} ]);
db.getCollection("products").insert([ {
    _id: ObjectId("62649fc27d460000c900224e"),
    id: NumberLong("5"),
    name: "ASUS ROG MAXIMUS X HERO",
    description: "Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX",
    price: 19310,
    "catalog_id": NumberInt("2"),
    "created_at": ISODate("2022-04-24T05:51:08.000Z"),
    "updated_at": ISODate("2022-04-24T05:51:08.000Z")
} ]);
db.getCollection("products").insert([ {
    _id: ObjectId("62649fc27d460000c900224f"),
    id: NumberLong("6"),
    name: "Gigabyte H310M S2H",
    description: "Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX",
    price: 4790,
    "catalog_id": NumberInt("2"),
    "created_at": ISODate("2022-04-24T05:51:08.000Z"),
    "updated_at": ISODate("2022-04-24T05:51:08.000Z")
} ]);
db.getCollection("products").insert([ {
    _id: ObjectId("62649fc27d460000c9002250"),
    id: NumberLong("7"),
    name: "MSI B250M GAMING PRO",
    description: "Материнская плата MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX",
    price: 5060,
    "catalog_id": NumberInt("2"),
    "created_at": ISODate("2022-04-24T05:51:08.000Z"),
    "updated_at": ISODate("2022-04-24T05:51:08.000Z")
} ]);
*/