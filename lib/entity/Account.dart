class Account {
  int id;
  String login;
  String password;
  String role;

  Account(this.id, this.login, this.password, this.role);

  String toJson(Account account) {
    return "{\"id\":\"${account.id}\",\"login\":\"${account.login}\",\"password\":\"${account.password}\",\"role\":\"${account.role}\"}";
  }

  Account.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        login = json['login'],
        password = json['password'],
        role = json['role'];

  @override
  String toString() {
    return 'Account{login: $login, password: $password}';
  }
}
