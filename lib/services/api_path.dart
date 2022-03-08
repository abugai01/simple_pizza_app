class APIPath {
  static String users() => 'users';
  static String user(String? uid) => 'users/$uid';
  static String items() => 'menu';
  static String item(String? id) => 'menu/$id';
  static String orders() => 'orders';
  static String order(String? id) => 'orders/$id';
}
