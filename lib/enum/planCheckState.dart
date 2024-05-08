enum planCheckState {
  noCheck(0),
  checking(1),
  checFail(2),
  planCheckSuc(3),
  memberChecking(4),
  memberCheckFail(5),
  allRight(6);

  final int number;
  const planCheckState(this.number);
}
