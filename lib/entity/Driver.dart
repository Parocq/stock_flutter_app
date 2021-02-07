class Driver {
  int id;
  String fio;
  String phoneNumber;

  Driver(this.id,this.fio,this.phoneNumber);

  String toJson(Driver driver) {
    return "{\"id\":\"${driver.id}\",\"fio\":\"${driver.fio}\",\"phoneNumber\":\"${driver.phoneNumber}\"}";
  }

  Driver.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        fio = json['fio'],
        phoneNumber = json['phoneNumber'];

  @override
  String toString() {
    return 'Driver{id: $id, fio: $fio, phoneNumber: $phoneNumber}';
  }
}