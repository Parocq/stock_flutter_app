class Account{
  String login;
  String password;

  Account(this.login,this.password);

  String toJson(Account account){
    return "{\"login\": \"${account.login}\",\"password\": \"${account.password}\"}";
  }
}