class ResetPassRequest{
  String userToken;
  String newPassword;
  String resetToken;

  ResetPassRequest( this.newPassword,this.userToken, this.resetToken);

  Map<String, dynamic> toJson() {
    return {
      'userToken': userToken,
      'newPassword': newPassword,
      'resetToken': resetToken,
    };
  }

}