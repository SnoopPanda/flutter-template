
enum ResultType {
  success,
  failed
}

class Result {
  ResultType type;
  var data;
  var errorMsg;

  Result(this.type,{
    this.data,
    this.errorMsg});
}