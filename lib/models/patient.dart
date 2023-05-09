class Patient {
  Patient(
    this.name,
    this.address,
    this.age,
    this.fbs,
    this.bpressure,
    this.allergics,
    this.other,
    this.mediRecords,
  );
  late String name;
  late String address;
  late int age;
  late int? fbs;
  late int? bpressure;
  late String? allergics;
  late String? other;
  late List<MediRecord> mediRecords = [];
}

class MediRecord {
  MediRecord(this.date, this.disease, this.treatment);
  late DateTime date;
  late String disease;
  late String treatment;
}
