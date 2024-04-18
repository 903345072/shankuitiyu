enum planCheckState {
  noCheck(0),
  checking(1),
  checFail(2),
  memberChecking(3),
  memberCheckFail(4),
  allRight(5);

  final int number;
  const planCheckState(this.number);
}
