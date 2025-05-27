class SubscriptionResponse {
  String message;
  String email;

  SubscriptionResponse(this.message, this.email);

  SubscriptionResponse.fromJson(Map<String, dynamic> json)
      : message = json['message'],
        email = json['data']['email'];

  Map<String, dynamic> toJson() => {
        'message': message,
        'data': {'email': email},
      };
}
