class GlobalsModel{
  late double tableImagesScale;

  GlobalsModel({
    required this.tableImagesScale
  });

  GlobalsModel.fromJson(Map<String, dynamic> json) {
    tableImagesScale = json['tableImagesScale'];
  }

  Map<String, dynamic> toJson() {
    return {
      'tableImagesScale': tableImagesScale,
    };
  }
}
