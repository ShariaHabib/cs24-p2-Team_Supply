class StatModel {
  double? dailyBills;
  double? monthlyBills;
  List<StsWasteCollected>? stsWasteCollected;
  bool? success;
  int? totalWasteCollected;
  int? totalWasteDisposed;
  double? weeklyBills;

  StatModel(
      {this.dailyBills,
      this.monthlyBills,
      this.stsWasteCollected,
      this.success,
      this.totalWasteCollected,
      this.totalWasteDisposed,
      this.weeklyBills});

  StatModel.fromJson(Map<String, dynamic> json) {
    dailyBills = json['daily_bills'];
    monthlyBills = json['monthly_bills'];
    if (json['sts_waste_collected'] != null) {
      stsWasteCollected = <StsWasteCollected>[];
      json['sts_waste_collected'].forEach((v) {
        stsWasteCollected!.add(new StsWasteCollected.fromJson(v));
      });
    }
    success = json['success'];
    totalWasteCollected = json['total_waste_collected'];
    totalWasteDisposed = json['total_waste_disposed'];
    weeklyBills = json['weekly_bills'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['daily_bills'] = this.dailyBills;
    data['monthly_bills'] = this.monthlyBills;
    if (this.stsWasteCollected != null) {
      data['sts_waste_collected'] =
          this.stsWasteCollected!.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    data['total_waste_collected'] = this.totalWasteCollected;
    data['total_waste_disposed'] = this.totalWasteDisposed;
    data['weekly_bills'] = this.weeklyBills;
    return data;
  }
}

class StsWasteCollected {
  int? stsId;
  int? totalVolumeCollected;

  StsWasteCollected({this.stsId, this.totalVolumeCollected});

  StsWasteCollected.fromJson(Map<String, dynamic> json) {
    stsId = json['sts_id'];
    totalVolumeCollected = json['total_volume_collected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sts_id'] = this.stsId;
    data['total_volume_collected'] = this.totalVolumeCollected;
    return data;
  }
}
