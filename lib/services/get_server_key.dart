import 'package:googleapis_auth/auth_io.dart';

class GetServerKey {
  Future<String> getServerKeyToken() async {
    final scopes = [
      'https://www.googleapis.com/auth/firebase.messaging',
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/firebase.database',
    ];

    final client = await clientViaServiceAccount(
      ServiceAccountCredentials.fromJson({
        "type": "service_account",
        "project_id": "hi-event-6d353",
        "private_key_id": "8c9dc68af4d41e25b81ede9500caf4d295061166",
        "private_key":
            "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDmIr18FAuZ9KmT\noTYkxG+Glcb4tEx5lCQpApnQsteZLZqtr9NysfZjCWEMubIhSzEoDpZexh2o2CXZ\nihzEoDIjmTARSL7tPONIsuCSG/Oh0AAcEu0k0u865UcvvTiTRCCHaQa4tfSLO7yJ\nOSpJpZb8TT2tMb0OiRgoQTWqAKRW1lAgT3SZ1tQS6RK2IynaMpMmBDQ6hTTU878s\nqEMU97bbIUzikxZ/0CmCJh35NtCdUGOAAjmTTeJrFsff84SDM3nXyV7X4FFIJ0YJ\nm+ntzJk+G0GfP/bw+E1lTUcJhn44D1HZO8oGL5UNu0kICBjmN8LiUrBgawdOlRVQ\nCNLk8s4pAgMBAAECggEAK12hgieO1hiF+eU3fC8t6tj/cO8cuA5D0ByG2o5Q1TME\nQjVvLV4+lQP37ztwxxhRr4AsMri3bxEn9LmzWRPszst3hNJF9BN0qsbWTYIJ41R8\nKM4iNL2wydLZmrPX3NxKGuoeE6Fp7vC3Qs5sWwtii7GMbT4Bp6MK088R6zKKxTfq\nsq9bwjlO1/SuY84pwsFAb6WpAZQyQjdgP33Z898m5KnSkqBfyzeZfGQ3E/2cN4+U\n02l1k4lYW8wYCwgpl2VX+TQpjrjQ97FdmrGMSVUz4wWCGrOkoqf4m//uLjxHY+n/\ne0UhY1whAPz/N7/RSfdpe9R3hyPhnlhQVNqOhDGoFwKBgQD/Pg8p/2ErSNFJsOxp\n8Axrc4wVcHx9xVM+wyTaPzQBJC2GrW9ayGA5Oq+7ystI2BuPrtMyCOu6qDO6CQpa\n7uoZmNI4pJW19e3180NCuS8+H3U531CZs7bJdRxMrTVd11BLKgcb7yeSVI4bfxCX\nnTqzNzgVMTdAkCvuFzy5TRS9IwKBgQDm0ZqnIM6BQ1RRnkUH7lDAGmfFlbf/WM9Z\n6OJaJ2KTa+AmF+QoQ9897AfKtLvFMES6trdrhPmBEl151oiMtPfZZibiUDjhBjOb\nJdv3EZeeoZ7IXVxXz/JVTsJElFblpaIHD/Vzl14nvnO/Wiife3NVurbeZdjpyE9/\nJz3bM81aQwKBgQC/1H2DG+uEo4Kf9reH2yEKdNoYluUJhY9OAU4mNRA5t1379UdW\nnHgtKt0+r2hfBASa1VLnLOs16wqNTBQbSappuIBuj8vw6LeCfOTVNea6stvgteSW\n0AmVmU2+lwMf1x4Cj8CuDuzXvnLbWYE34bRnUx30V3vmKzTJCW/a+IKYrwKBgQCj\nPGDvCRiB+ifLgO646SVadlIlPfjeMOSTZUuPDoN8VrIyvnqwry9WD3KDPMX+cmBo\n24dkFqqNSXuqCrqPJ/yQVtnw+2L+YPBmLKQfWuWrXgl5Ee2YfIuZIRXqgi3iQv0P\nmY2wrb/8w4gAL7bC8v9iBaYGKmj5DJyMBCiOuVflGQKBgHWN7Bny61So7T1VhyN2\nbfhXJEcykeWx1zsj9J/BNeDNkTESSTOOnvAKb2lI+ti1WRsRoj+LGeWg8c5A+0kW\nt4Wv3UNqEeCjSz3ILNf5nHmSe/bItLNh/i8F+ofu+kiVZe9oDgBLccmZmamokPWx\npGGy2eowbjtOQe72dcBG9WLY\n-----END PRIVATE KEY-----\n",
        "client_email":
            "firebase-adminsdk-fbsvc@hi-event-6d353.iam.gserviceaccount.com",
        "client_id": "117908432224696537188",
        "auth_uri": "https://accounts.google.com/o/oauth2/auth",
        "token_uri": "https://oauth2.googleapis.com/token",
        "auth_provider_x509_cert_url":
            "https://www.googleapis.com/oauth2/v1/certs",
        "client_x509_cert_url":
            "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-fbsvc%40hi-event-6d353.iam.gserviceaccount.com",
        "universe_domain": "googleapis.com",
      }),
      scopes,
    );
    final accessServerKey = await client.credentials.accessToken.data;
    // This is a placeholder for the actual implementation.
    // In a real application, you would retrieve the server key from a secure source.
    return accessServerKey;
  }
}
