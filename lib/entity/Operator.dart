import 'package:stock_flutter_app/entity/Account.dart';

class Operator {
  int id;
  String fio;
  String phoneNumber;
  Account account;

  Operator(this.id, this.fio, this.phoneNumber, this.account);

  String toJson(Operator operator) {
    return "{\"id\":\"${operator.id}\",\"fio\":\"${operator.fio}\",\"phoneNumber\": \"${operator.phoneNumber}\",\"account\":{\"id\":\"${account.id}\",\"login\":\"${account.login}\",\"password\": \"${account.password}\",\"role\":\"${account.role}\"}}";
  }

  Operator.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        fio = json['fio'],
        phoneNumber = json['phoneNumber'],
        account = Account.fromJson(json['account']);

  @override
  String toString() {
    return 'Operator{id: $id, fio: $fio, phoneNumber: $phoneNumber, account: $account}';
  }
}
