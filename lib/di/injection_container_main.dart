part of 'injection_container.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Dio
  sl.registerSingleton<Dio>(Dio()).interceptors.add(TokenInterceptor());
  // Login =====================================================
  // datasource
  sl.registerSingleton<AuthenRemoteDataSrc>(
    AuthenRemoteDataSrcImpl(
      sl<Dio>(),
    ),
  );
  sl.registerSingleton<AuthenLocalDataSrc>(
    AuthenLocalDataSrcImpl(await SharedPreferences.getInstance()),
  );

  sl.registerLazySingleton<FlutterSecureStorage>(FlutterSecureStorage.new);

  sl.registerSingleton<UserStorage>(
    SecureUserStorage(
      sl<FlutterSecureStorage>(),
    ),
  );
  // repository
  sl.registerSingleton<AuthenticationRepository>(
    AuthenticationRepositoryImpl(
      sl<AuthenRemoteDataSrc>(),
      sl<AuthenLocalDataSrc>(),
      sl<UserStorage>(),
    ),
  );
  // use cases

  sl.registerSingleton<CheckTokenUseCase>(
    CheckTokenUseCase(
      sl<AuthenticationRepository>(),
    ),
  );

  sl.registerSingleton<GetUserIdUseCase>(
    GetUserIdUseCase(
      sl<AuthenticationRepository>(),
    ),
  );

  sl.registerSingleton<GetAccessTokenUseCase>(
    GetAccessTokenUseCase(
      sl<AuthenticationRepository>(),
    ),
  );

  sl.registerSingleton<UpdateProfileUseCase>(
    UpdateProfileUseCase(
      sl<AuthenticationRepository>(),
    ),
  );

  //Post=====================================================
  // datasource
  sl.registerSingleton<PostRemoteDataSrc>(
    PostRemoteDataSrcImpl(
      sl<Dio>(),
    ),
  );

  sl.registerSingleton<MediaRemoteDataSource>(
    MediaRemoteDataSourceImpl(
      sl<Dio>(),
    ),
  );
  // post repository
  sl.registerSingleton<PostRepository>(
    PostRepositoryImpl(
      sl<PostRemoteDataSrc>(),
    ),
  );

  sl.registerSingleton<MediaRepository>(
    MediaRepositoryImpl(
      sl<MediaRemoteDataSource>(),
    ),
  );

  // use cases
  sl.registerSingleton<GetPostsUseCase>(
    GetPostsUseCase(
      sl<PostRepository>(),
    ),
  );

  sl.registerSingleton<GetPostsLendingUseCase>(
    GetPostsLendingUseCase(
      sl<PostRepository>(),
    ),
  );

  sl.registerSingleton<GetPostsBorrowingUseCase>(
    GetPostsBorrowingUseCase(
      sl<PostRepository>(),
    ),
  );

  sl.registerSingleton<GetPostsApprovedUseCase>(
    GetPostsApprovedUseCase(
      sl<PostRepository>(),
    ),
  );

  sl.registerSingleton<GetPostsPendingUseCase>(
    GetPostsPendingUseCase(
      sl<PostRepository>(),
    ),
  );

  sl.registerSingleton<GetPostsRejectUseCase>(
    GetPostsRejectUseCase(
      sl<PostRepository>(),
    ),
  );

  sl.registerSingleton<GetPostsHidedUseCase>(
    GetPostsHidedUseCase(
      sl<PostRepository>(),
    ),
  );

  sl.registerSingleton<CreatePostsUseCase>(
    CreatePostsUseCase(
      sl<PostRepository>(),
    ),
  );

  sl.registerSingleton<UploadImagesUseCase>(
    UploadImagesUseCase(
      sl<MediaRepository>(),
    ),
  );

  sl.registerSingleton<UploadVideosUseCase>(
    UploadVideosUseCase(
      sl<MediaRepository>(),
    ),
  );

  // Contract =====================================================
  // datasource
  sl.registerSingleton<RequestRemoteDataSrc>(
    RequestRemoteDataSrcImpl(
      sl<Dio>(),
    ),
  );

  // repository
  sl.registerSingleton<RequestRepository>(
    RequestRepositoryImpl(
      sl<RequestRemoteDataSrc>(),
    ),
  );

  // use cases
  sl.registerSingleton<GetRequestUseCase>(
    GetRequestUseCase(
      sl<RequestRepository>(),
    ),
  );

  sl.registerSingleton<GetRequestApprovedUseCase>(
    GetRequestApprovedUseCase(
      sl<RequestRepository>(),
    ),
  );

  sl.registerSingleton<GetRequestPendingUseCase>(
    GetRequestPendingUseCase(
      sl<RequestRepository>(),
    ),
  );

  sl.registerSingleton<GetRequestRejectedUseCase>(
    GetRequestRejectedUseCase(
      sl<RequestRepository>(),
    ),
  );

  sl.registerSingleton<CreateRequestsUseCase>(
    CreateRequestsUseCase(
      sl<RequestRepository>(),
    ),
  );

  sl.registerSingleton<GetRequestSentUseCase>(
    GetRequestSentUseCase(
      sl<RequestRepository>(),
    ),
  );

  sl.registerSingleton<GetRequestWaitingPaymentUseCase>(
    GetRequestWaitingPaymentUseCase(
      sl<RequestRepository>(),
    ),
  );

  sl.registerSingleton<GetBorrowingContractsUseCase>(
    GetBorrowingContractsUseCase(
      sl<RequestRepository>(),
    ),
  );

  sl.registerSingleton<GetLendingContractsUseCase>(
    GetLendingContractsUseCase(
      sl<RequestRepository>(),
    ),
  );

  sl.registerSingleton<ConfirmRequestUseCase>(
    ConfirmRequestUseCase(
      sl<RequestRepository>(),
    ),
  );

  sl.registerSingleton<RejectRequestUseCase>(
    RejectRequestUseCase(
      sl<RequestRepository>(),
    ),
  );
  //MembershipPackage=====================================================
  // datasource
  sl.registerSingleton<MembershipPackageRemoteDataSrc>(
    MembershipPackageRemoteDataSrcImpl(
      sl<Dio>(),
    ),
  );
  // membership package repository'
  sl.registerSingleton<MembershipPackageRepository>(
    MembershipPackageRepositoryImpl(
      sl<MembershipPackageRemoteDataSrc>(),
    ),
  );

  // use cases
  sl.registerSingleton<GetMembershipPackageUseCase>(
    GetMembershipPackageUseCase(
      sl<MembershipPackageRepository>(),
    ),
  );

  //Transaction=====================================================
  sl.registerSingleton<TransactionRemoteDataSrc>(
    TransactionRemoteDataSrcImpl(
      sl<Dio>(),
    ),
  );

  sl.registerSingleton<TransactionRepository>(
    TranstractionRepositoryImpl(
      sl<TransactionRemoteDataSrc>(),
    ),
  );

  // use cases
  sl.registerSingleton<GetTransactionUseCase>(
    GetTransactionUseCase(
      sl<TransactionRepository>(),
    ),
  );

  sl.registerSingleton<GetOrderMembershipPackageUseCase>(
    GetOrderMembershipPackageUseCase(
      sl<MembershipPackageRepository>(),
    ),
  );

  // Blog =====================================================
  // blog repository
  sl.registerSingleton<BlogRemoteDataSrc>(
    BlogRemoteDataSrcImpl(
      sl<Dio>(),
    ),
  );

  sl.registerSingleton<BlogRepository>(
    BlogRepositoryImpl(
      sl<BlogRemoteDataSrc>(),
    ),
  );

  sl.registerSingleton<GetBlogsUseCase>(
    GetBlogsUseCase(
      sl<BlogRepository>(),
    ),
  );

  // Provinces =====================================================
  // provinces repository
  sl.registerSingleton<ProvincesRepository>(
    ProvincesRepositoryImpl(),
  );
  // use cases
  sl.registerSingleton<GetAddressUseCase>(
    GetAddressUseCase(
      sl<ProvincesRepository>(),
    ),
  );

  sl.registerSingleton<GetProvinceNamesUseCase>(
    GetProvinceNamesUseCase(
      sl<ProvincesRepository>(),
    ),
  );

  sl.registerSingleton<SignInUseCase>(
    SignInUseCase(sl<AuthenticationRepository>()),
  );

  sl.registerSingleton<SignOutUseCase>(
    SignOutUseCase(
      sl<AuthenticationRepository>(),
    ),
  );

  sl.registerSingleton<SignUpUseCase>(
    SignUpUseCase(
      sl<AuthenticationRepository>(),
    ),
  );

  sl.registerSingleton<PayLoanRequestUsecase>(
    PayLoanRequestUsecase(
      sl<RequestRepository>(),
    ),
  );

  sl.registerSingleton<UserRemoteDataSrc>(
    UserRemoteDataSrcImpl(
      sl<Dio>(),
    ),
  );

  sl.registerSingleton<UserRepository>(
    UserRepositoryImpl(
      sl<UserRemoteDataSrc>(),
      sl<UserStorage>(),
    ),
  );

  sl.registerSingleton<SearchUserUseCase>(
    SearchUserUseCase(
      sl<UserRepository>(),
    ),
  );

  sl.registerSingleton<GetProfileUseCase>(
    GetProfileUseCase(
      sl<UserRepository>(),
    ),
  );

  // bank =====================================================
  sl.registerSingleton<BankRemoteDataSrc>(
    BankRemoteDataSrcImpl(
      sl<Dio>(),
    ),
  );

  sl.registerSingleton<BankRepository>(
    BankRepositoryImpl(
      sl<BankRemoteDataSrc>(),
    ),
  );

  sl.registerSingleton<GetAllbankUseCase>(
    GetAllbankUseCase(
      sl<BankRepository>(),
    ),
  );

  sl.registerSingleton<GetBankCardsUseCase>(
    GetBankCardsUseCase(
      sl<BankRepository>(),
    ),
  );

  sl.registerSingleton<MarkAsPrimaryBankCardsUseCase>(
    MarkAsPrimaryBankCardsUseCase(
      sl<BankRepository>(),
    ),
  );

  sl.registerSingleton<AddBankCardUseCase>(
    AddBankCardUseCase(
      sl<BankRepository>(),
    ),
  );

  sl.registerSingleton<DeleteBankCardUseCase>(
    DeleteBankCardUseCase(
      sl<BankRepository>(),
    ),
  );

  sl.registerSingleton<GetPrimaryBankCardUseCase>(
    GetPrimaryBankCardUseCase(
      sl<BankRepository>(),
    ),
  );
}
