class AudioArray {
  List<int>? array;

  AudioArray({this.array});

  AudioArray.fromJson(Map<String, dynamic> json) {
    array = json['array'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['array'] = this.array;
    return data;
  }
}
