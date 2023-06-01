enum Status {
  success,failed,loading
}

class Resource<T> {
  Status? status;
  T? data;
  String? message;
  int? statusCode;

  Resource.loading(): status = Status.loading;
  Resource.error(this.message,this.statusCode) : status = Status.failed;
  Resource.success(this.data) : status = Status.success;

}