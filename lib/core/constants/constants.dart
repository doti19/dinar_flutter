// const ipConfig = "192.168.1.3:3000";
const ipConfig = "10.0.2.2:3000";
// const ipConfig = "93.127.186.109:3000";
const bool isProduction = false;
// const String apiDevUrl = "http://$ipConfig:8000/api/v1";
const String apiDevBaseUrl = "http://$ipConfig";
const String apiDevUrl = "$apiDevBaseUrl/api/v1";
const String apiDevAuthUrl = "$apiDevBaseUrl/auth";
const String apiProductionUrl = "https://eight8credit.onrender.com/api/v1";
const String apiUrl = isProduction ? apiProductionUrl : apiDevUrl;
//const String apiAppUrl = isProduction ? apiProductionUrl : apiDevUrl;
const String kSignIn = '/login';
const String kSignUp = '/register';
const String kChangePassword = '/changePassword';
const String kSignOut = '/logout';
const String kSignOutAll = '/auth/sign-out-all';
const String kActiveAccount = '/auth/active-account';
const String kResendActivationCode = '/auth/resend-activation-code';
const String kRefreshToken = '/refresh';
const String kResetPassword = '/resetpassword';
const String kRequestResetPassword = '/requestResetPassword';
const String kSendVerificationSMS = '/sendverificationSMS';
const String kVerifyPhoneOTP = '/verifyPhoneOTP';

const String kGetPostEndpoint = '/posts';
const String kCreatePostEndpoint = '/posts';
const String kGetMembershipPackageEndpoint = '/membership-package';
const String kGetTransactionEndpoint = '/membership-package/transactions';
const String kCreateOrderEndpoint = '/membership-package/check-out';
const String kGetBlogEndpoint = '/blogs';

const String kGetRequestEndpoint = '/loan-requests';
const String kPayLoanRequestEndpoint = '/loan-requests';
const String kCreateRequestEndpoint = '/loan-requests';
const String kConfirmRequestEndpoint = '/loan-requests';
const String kRejectRequestEndpoint = '/loan-request';

const String kGetUserEndpoint = '/users';

const String kGetContractEndpoint = '/loan-contracts';
const String kGetMe = '/users/profile';
const String kUpdateMe = '/users/profile';

const String kGetBankEndpoint = '/bank';
const String kGetBankCardEndpoint = '/bank-cards';
const String kGetPrimaryBankCardEndpoint = '/bank-cards/primary';
const String kGetMarkPrimaryEndpoint = '/mark-as-primary';
