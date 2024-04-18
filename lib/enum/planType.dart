enum planType {
  jcFoot(1, 'jc_foot'),

  rq(2, 'rq'),

  daxiaoqiu(3, 'dxq'),
  rfsf(4, 'rfsf'),
  dxf(5, 'dxf');

  const planType(this.number, this.value);

  final int number;

  final String value;
  static planType getTypeByTitle(String title) =>
      planType.values.firstWhere((activity) => activity.name == title);
  static planType getType(int number) =>
      planType.values.firstWhere((activity) => activity.number == number);

  static String getValue(int number) =>
      planType.values.firstWhere((activity) => activity.number == number).value;
}
