class InflowAndOutflowModel {
  int? inflow;
  int? outtflow;

  InflowAndOutflowModel({this.inflow, this.outtflow});

  InflowAndOutflowModel.fromJson(Map<String, dynamic> json) {
    inflow = json['inflow'];
    outtflow = json['outtflow'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['inflow'] = inflow;
    data['outtflow'] = outtflow;
    return data;
  }
}
