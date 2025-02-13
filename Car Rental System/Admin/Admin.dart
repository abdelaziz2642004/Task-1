class Admin {
  String _UserName;
  String _Password;
  Admin({required String UserName, required String Password})
      : this._UserName = UserName,
        this._Password = Password;

  String get username => _UserName; // getter
  String get password => _Password; // getter
}
