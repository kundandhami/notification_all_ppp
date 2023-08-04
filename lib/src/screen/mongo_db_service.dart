import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';

class MongoDBService {
  static connection() async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    inspect(db);
    print(db.serverStatus());
    var collection = db.collection(COLLECTIONNAME);
  }
}

const String MONGO_URL =
    "mongodb+srv://techbothard:kundandb@kundan.nfdtynj.mongodb.net/test?retryWrites=true&w=majority";
const String COLLECTIONNAME = "users";
