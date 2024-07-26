import 'package:dinar/features/data/models/credit/contract.dart';
import 'package:dinar/features/data/models/credit/loan_request.dart';
import 'package:dinar/features/data/models/credit/post.dart';
import 'package:dinar/features/domain/entities/credit/bank.dart';
import 'package:dinar/features/domain/entities/credit/bank_card.dart';
import 'package:dinar/features/domain/entities/credit/user.dart';
import 'package:dinar/features/domain/entities/nhagiare/posts/address.dart';
import 'package:dinar/features/domain/enums/loan_contract_request_status.dart';
import 'package:dinar/features/domain/enums/loan_reason_types.dart';
import 'package:dinar/features/domain/enums/post_status.dart';
import 'package:dinar/features/domain/enums/post_type.dart';
import 'package:dinar/features/domain/enums/role.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/resources/pair.dart';
import '../../../../core/utils/typedef.dart';
import '../../../../di/injection_container.dart';
import '../local/authentication_local_data_source.dart';

class DatabaseHelper {
  Future<HttpResponse<Pair<int, List<PostModel>>>> getPosts(
      String url, Dio client) async {
    try {
      print(url);
      AuthenLocalDataSrc localDataSrc = sl<AuthenLocalDataSrc>();
      String? accessToken = localDataSrc.getAccessToken();
      if (accessToken == null) {
        throw const ApiException(
            message: 'Access token is null', statusCode: 505);
      }
      final response = await client.get(url,
          options: Options(
              sendTimeout: const Duration(seconds: 10),
              headers: {'Authorization': 'Bearer $accessToken'}));
      //print('${response.statusCode} : ${response.data["message"].toString()}');
      if (response.statusCode != 200) {
        //print('${response.statusCode} : ${response.data["result"].toString()}');
        throw ApiException(
          message: response.data,
          statusCode: response.statusCode!,
        );
      }

      final int numOfPages = response.data["num_of_pages"];
      // print('shwarma ${response.data}');

      final List<DataMap> taskDataList =
          List<DataMap>.from(response.data["result"]);

      List<PostModel> posts = [];
      for (var element in taskDataList) {
        posts.add(PostModel.fromJson(element));
      }
      print('germany ${posts.length}');
      // posts = [
      //   PostModel(
      //     createdAt: DateTime.now(),
      //     id: "1005",
      //     description: "desc",
      //     images: [
      //       "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQP_Mj7kgeXBDNwFqlQ0Ug9WgkV1kd96cSTYg&s",
      //       "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQdEDzIyVdNLYHlVCjXJa3Xh9dGFextZyA9Yg&s",
      //       "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSnAPe38Sr4_7rb9XlcQHfiXxY7m59lfBpBcA&s"
      //     ],
      //     interestRate: 3.5,
      //     loanAmount: 10000,
      //     loanReason: "Personal Development",
      //     loanReasonType: LoanReasonTypes.carBuying,
      //     maxInterestRate: 45,
      //     maxLoanAmount: 14,
      //     maxOverdueInterestRate: 10,
      //     maxTenureMonths: 12,
      //     overdueInterestRate: 10,
      //     rejectedReason: "",
      //     status: PostStatus.pending,
      //     tenureMonths: 3,
      //     title: "Recent Loan Request",
      //     type: PostTypes.inKind,
      //     user: UserEntity(
      //       email: "lidya@gmail.com",
      //       gender: "female",
      //       id: "1005",
      //       phone: "0914281719",
      //       role: Role.user,
      //       avatar:
      //           "https://cdni.iconscout.com/illustration/premium/thumb/young-girl-8187687-6590629.png?f=webp",
      //       firstName: "Lidya",
      //       lastName: "Abebe",
      //       address: AddressEntity(
      //         "22 Mazorya",
      //         city: "AddisAbaba",
      //         country: "Ethiopia",
      //         stateProvince: "AA",
      //         streetAddress: "Bole",
      //       ),
      //     ),
      //   ),
      //   PostModel(
      //     createdAt: DateTime.now(),
      //     id: "1005",
      //     description: "desc",
      //     images: [
      //       "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQP_Mj7kgeXBDNwFqlQ0Ug9WgkV1kd96cSTYg&s",
      //       "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQdEDzIyVdNLYHlVCjXJa3Xh9dGFextZyA9Yg&s",
      //       "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSnAPe38Sr4_7rb9XlcQHfiXxY7m59lfBpBcA&s"
      //     ],
      //     interestRate: 3.5,
      //     loanAmount: 10000,
      //     loanReason: "Personal Development",
      //     loanReasonType: LoanReasonTypes.carBuying,
      //     maxInterestRate: 45,
      //     maxLoanAmount: 14,
      //     maxOverdueInterestRate: 10,
      //     maxTenureMonths: 12,
      //     overdueInterestRate: 10,
      //     rejectedReason: "",
      //     status: PostStatus.pending,
      //     tenureMonths: 3,
      //     title: "Recent Loan Request",
      //     type: PostTypes.inKind,
      //     user: UserEntity(
      //       email: "lidya@gmail.com",
      //       gender: "female",
      //       id: "1005",
      //       phone: "0914281719",
      //       role: Role.user,
      //       avatar:
      //           "https://img.freepik.com/free-psd/3d-illustration-human-avatar-profile_23-2150671122.jpg?w=740&t=st=1720607997~exp=1720608597~hmac=9e386cfdd712a2fd819b7a1ce9a773b15c8292c3e31734f1add60ab99dfa335a",
      //       firstName: "Natnael",
      //       lastName: "Belay",
      //       address: AddressEntity(
      //         "22 Mazorya",
      //         city: "AddisAbaba",
      //         country: "Ethiopia",
      //         stateProvince: "AA",
      //         streetAddress: "Bole",
      //       ),
      //     ),
      //   ),
      //   PostModel(
      //     createdAt: DateTime.now(),
      //     id: "1005",
      //     description: "desc",
      //     images: [
      //       "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQP_Mj7kgeXBDNwFqlQ0Ug9WgkV1kd96cSTYg&s",
      //       "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQdEDzIyVdNLYHlVCjXJa3Xh9dGFextZyA9Yg&s",
      //       "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSnAPe38Sr4_7rb9XlcQHfiXxY7m59lfBpBcA&s"
      //     ],
      //     interestRate: 3.5,
      //     loanAmount: 10000,
      //     loanReason: "Personal Development",
      //     loanReasonType: LoanReasonTypes.carBuying,
      //     maxInterestRate: 45,
      //     maxLoanAmount: 14,
      //     maxOverdueInterestRate: 10,
      //     maxTenureMonths: 12,
      //     overdueInterestRate: 10,
      //     rejectedReason: "",
      //     status: PostStatus.pending,
      //     tenureMonths: 3,
      //     title: "Recent Loan Request",
      //     type: PostTypes.inKind,
      //     user: UserEntity(
      //       email: "nahom@gmail.com",
      //       gender: "male",
      //       id: "1005",
      //       phone: "0914281719",
      //       role: Role.user,
      //       avatar:
      //           "https://img.freepik.com/free-vector/blond-man-character-icon-isolated_18591-83007.jpg?size=626&ext=jpg&ga=GA1.2.1571368897.1718005249&semt=ais_hybrid",
      //       firstName: "Lidya",
      //       lastName: "Abebe",
      //       address: AddressEntity(
      //         "22 Mazorya",
      //         city: "AddisAbaba",
      //         country: "Ethiopia",
      //         stateProvince: "AA",
      //         streetAddress: "Bole",
      //       ),
      //     ),
      //   ),
      //   PostModel(
      //     createdAt: DateTime.now(),
      //     id: "1005",
      //     description: "desc",
      //     images: [
      //       "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQP_Mj7kgeXBDNwFqlQ0Ug9WgkV1kd96cSTYg&s",
      //       "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQdEDzIyVdNLYHlVCjXJa3Xh9dGFextZyA9Yg&s",
      //       "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSnAPe38Sr4_7rb9XlcQHfiXxY7m59lfBpBcA&s"
      //     ],
      //     interestRate: 3.5,
      //     loanAmount: 10000,
      //     loanReason: "Personal Development",
      //     loanReasonType: LoanReasonTypes.carBuying,
      //     maxInterestRate: 45,
      //     maxLoanAmount: 14,
      //     maxOverdueInterestRate: 10,
      //     maxTenureMonths: 12,
      //     overdueInterestRate: 10,
      //     rejectedReason: "",
      //     status: PostStatus.pending,
      //     tenureMonths: 3,
      //     title: "Recent Loan Request",
      //     type: PostTypes.inKind,
      //     user: UserEntity(
      //       email: "lidya@gmail.com",
      //       gender: "female",
      //       id: "1005",
      //       phone: "0914281719",
      //       role: Role.user,
      //       avatar:
      //           "https://cdni.iconscout.com/illustration/premium/thumb/young-girl-8187687-6590629.png?f=webp",
      //       firstName: "Yared",
      //       lastName: "Tilahun",
      //       address: AddressEntity(
      //         "22 Mazorya",
      //         city: "AddisAbaba",
      //         country: "Ethiopia",
      //         stateProvince: "AA",
      //         streetAddress: "Bole",
      //       ),
      //     ),
      //   ),
      // ];

      final value = Pair(numOfPages, posts);

      return HttpResponse(value, response);
    } on ApiException {
      rethrow;
    } catch (error) {
      error.printError();
      throw ApiException(message: error.toString(), statusCode: 505);
    }
  }

  Future<HttpResponse<Pair<int, List<LoanRequestModel>>>> getRequests(
      String url, Dio client) async {
    try {
      // get access token
      AuthenLocalDataSrc localDataSrc = sl<AuthenLocalDataSrc>();
      String? accessToken = localDataSrc.getAccessToken();
      if (accessToken == null) {
        throw const ApiException(
            message: 'Access token is null', statusCode: 505);
      }

      final response = await client.get(
        url,
        options: Options(
            sendTimeout: const Duration(seconds: 10),
            headers: {'Authorization': 'Bearer $accessToken'}),
      );
      print(url);
      //print('${response.statusCode} : ${response.data["message"].toString()}');
      if (response.statusCode != 200) {
        //print('${response.statusCode} : ${response.data["result"].toString()}');
        throw ApiException(
          message: response.data,
          statusCode: response.statusCode!,
        );
      }

      final int numOfPages = response.data["num_of_pages"];

      final List<DataMap> taskDataList =
          List<DataMap>.from(response.data["result"]);

      List<LoanRequestModel> posts = [];
      for (var element in taskDataList) {
        posts.add(LoanRequestModel.fromJson(element));
      }

      posts = [
        LoanRequestModel(
            createdAt: DateTime.now(),
            description: "loan request",
            id: "3003",
            interestRate: 44,
            idCardBackPhoto:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkZUUzPWexwYFKYLr3eR81HIW6UGWZcAKoSQ&s',
            idCardFrontPhoto:
                'https://m.media-amazon.com/images/I/81kGjrseg6L._AC_UF1000,1000_QL80_.jpg',
            loanReason: "Purchase",
            loanAmount: 60000,
            loanReasonType: LoanReasonTypes.business,
            loanTenureMonths: 5,
            overdueInterestRate: 14,
            portaitPhoto:
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkZUUzPWexwYFKYLr3eR81HIW6UGWZcAKoSQ&s",
            receiver: UserEntity(
                email: "lidya@gmail.com",
                gender: "female",
                id: "1005",
                phone: "0914281719",
                role: Role.user,
                avatar:
                    "https://cdni.iconscout.com/illustration/premium/thumb/young-girl-8187687-6590629.png?f=webp",
                firstName: "Lidya",
                lastName: "Abebe",
                address: AddressEntity(
                  "22 Mazorya",
                  city: "AddisAbaba",
                  country: "Ethiopia",
                  stateProvince: "AA",
                  streetAddress: "Bole",
                )),
            receiverBankCard: BankCardEntity(
                bank: BankEntity(
                  name: "Abissinia",
                  shortName: "AIB",
                  bin: "thisbin",
                  code: "1234",
                  id: "2001",
                  logo:
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQelz9TbWV_irdMk7ncyxyT5V451aYpt7Xy6Q&s",
                ),
                bankId: "001",
                branch: "Bole",
                cardNumber: "1001",
                createdAt: DateTime.now(),
                deletedAt: DateTime.now(),
                id: "001",
                isPrimary: true,
                userId: "112"),
            senderBankCard: BankCardEntity(
                bank: BankEntity(
                  name: "Abissinia",
                  shortName: "AIB",
                  bin: "thisbin",
                  code: "1234",
                  id: "2001",
                  logo:
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQelz9TbWV_irdMk7ncyxyT5V451aYpt7Xy6Q&s",
                ),
                bankId: "001",
                branch: "Bole",
                cardNumber: "1001",
                createdAt: DateTime.now(),
                deletedAt: DateTime.now(),
                id: "001",
                isPrimary: true,
                userId: "112"),
            sender: UserEntity(
              email: "lidya@gmail.com",
              gender: "female",
              id: "1005",
              phone: "0914281719",
              role: Role.user,
              avatar:
                  "https://cdni.iconscout.com/illustration/premium/thumb/young-girl-8187687-6590629.png?f=webp",
              firstName: "Rodas",
              lastName: "Gesese",
              address: AddressEntity(
                "22 Mazorya",
                city: "AddisAbaba",
                country: "Ethiopia",
                stateProvince: "AA",
                streetAddress: "Bole",
              ),
            ),
            updatedAt: DateTime.now(),
            deletedAt: DateTime.now(),
            receiverBankCardId: "1234",
            rejectedReason: "",
            senderBankCardId: "12344",
            status: LoanContractRequestStatus.pending,
            videoConfirmation:
                "https://media.istockphoto.com/id/1212501173/video/confident-businessman-business-coach-speak-look-at-camera-in-office.mp4?s=mp4-640x640-is&k=20&c=NWApS_7qsVoU_uXPtIErYdd4s3HR_YMzRxCasphAWQI="),
        LoanRequestModel(
            createdAt: DateTime.now(),
            description: "loan request",
            id: "3003",
            interestRate: 44,
            idCardBackPhoto:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkZUUzPWexwYFKYLr3eR81HIW6UGWZcAKoSQ&s',
            idCardFrontPhoto:
                'https://m.media-amazon.com/images/I/81kGjrseg6L._AC_UF1000,1000_QL80_.jpg',
            loanReason: "Purchase",
            loanAmount: 60000,
            loanReasonType: LoanReasonTypes.business,
            loanTenureMonths: 5,
            overdueInterestRate: 14,
            portaitPhoto:
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkZUUzPWexwYFKYLr3eR81HIW6UGWZcAKoSQ&s",
            receiver: UserEntity(
                email: "lidya@gmail.com",
                gender: "female",
                id: "1005",
                phone: "0914281719",
                role: Role.user,
                avatar:
                    "https://cdni.iconscout.com/illustration/premium/thumb/young-girl-8187687-6590629.png?f=webp",
                firstName: "Lidya",
                lastName: "Abebe",
                address: AddressEntity(
                  "22 Mazorya",
                  city: "AddisAbaba",
                  country: "Ethiopia",
                  stateProvince: "AA",
                  streetAddress: "Bole",
                )),
            receiverBankCard: BankCardEntity(
                bank: BankEntity(
                  name: "Abissinia",
                  shortName: "AIB",
                  bin: "thisbin",
                  code: "1234",
                  id: "2001",
                  logo:
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQelz9TbWV_irdMk7ncyxyT5V451aYpt7Xy6Q&s",
                ),
                bankId: "001",
                branch: "Bole",
                cardNumber: "1001",
                createdAt: DateTime.now(),
                deletedAt: DateTime.now(),
                id: "001",
                isPrimary: true,
                userId: "112"),
            senderBankCard: BankCardEntity(
                bank: BankEntity(
                  name: "Abissinia",
                  shortName: "AIB",
                  bin: "thisbin",
                  code: "1234",
                  id: "2001",
                  logo:
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQelz9TbWV_irdMk7ncyxyT5V451aYpt7Xy6Q&s",
                ),
                bankId: "001",
                branch: "Bole",
                cardNumber: "1001",
                createdAt: DateTime.now(),
                deletedAt: DateTime.now(),
                id: "001",
                isPrimary: true,
                userId: "112"),
            sender: UserEntity(
              email: "lidya@gmail.com",
              gender: "female",
              id: "1005",
              phone: "0914281719",
              role: Role.user,
              avatar:
                  "https://cdni.iconscout.com/illustration/premium/thumb/young-girl-8187687-6590629.png?f=webp",
              firstName: "Lidya",
              lastName: "Abebe",
              address: AddressEntity(
                "22 Mazorya",
                city: "AddisAbaba",
                country: "Ethiopia",
                stateProvince: "AA",
                streetAddress: "Bole",
              ),
            ),
            updatedAt: DateTime.now(),
            deletedAt: DateTime.now(),
            receiverBankCardId: "1234",
            rejectedReason: "",
            senderBankCardId: "12344",
            status: LoanContractRequestStatus.pending,
            videoConfirmation:
                "https://media.istockphoto.com/id/1212501173/video/confident-businessman-business-coach-speak-look-at-camera-in-office.mp4?s=mp4-640x640-is&k=20&c=NWApS_7qsVoU_uXPtIErYdd4s3HR_YMzRxCasphAWQI="),
        LoanRequestModel(
            createdAt: DateTime.now(),
            description: "loan request",
            id: "3003",
            interestRate: 44,
            idCardBackPhoto:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkZUUzPWexwYFKYLr3eR81HIW6UGWZcAKoSQ&s',
            idCardFrontPhoto:
                'https://m.media-amazon.com/images/I/81kGjrseg6L._AC_UF1000,1000_QL80_.jpg',
            loanReason: "Purchase",
            loanAmount: 60000,
            loanReasonType: LoanReasonTypes.business,
            loanTenureMonths: 5,
            overdueInterestRate: 14,
            portaitPhoto:
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkZUUzPWexwYFKYLr3eR81HIW6UGWZcAKoSQ&s",
            receiver: UserEntity(
                email: "lidya@gmail.com",
                gender: "female",
                id: "1005",
                phone: "0914281719",
                role: Role.user,
                avatar:
                    "https://cdni.iconscout.com/illustration/premium/thumb/young-girl-8187687-6590629.png?f=webp",
                firstName: "Lidya",
                lastName: "Abebe",
                address: AddressEntity(
                  "22 Mazorya",
                  city: "AddisAbaba",
                  country: "Ethiopia",
                  stateProvince: "AA",
                  streetAddress: "Bole",
                )),
            receiverBankCard: BankCardEntity(
                bank: BankEntity(
                  name: "Abissinia",
                  shortName: "AIB",
                  bin: "thisbin",
                  code: "1234",
                  id: "2001",
                  logo:
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQelz9TbWV_irdMk7ncyxyT5V451aYpt7Xy6Q&s",
                ),
                bankId: "001",
                branch: "Bole",
                cardNumber: "1001",
                createdAt: DateTime.now(),
                deletedAt: DateTime.now(),
                id: "001",
                isPrimary: true,
                userId: "112"),
            senderBankCard: BankCardEntity(
                bank: BankEntity(
                  name: "Abissinia",
                  shortName: "AIB",
                  bin: "thisbin",
                  code: "1234",
                  id: "2001",
                  logo:
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQelz9TbWV_irdMk7ncyxyT5V451aYpt7Xy6Q&s",
                ),
                bankId: "001",
                branch: "Bole",
                cardNumber: "1001",
                createdAt: DateTime.now(),
                deletedAt: DateTime.now(),
                id: "001",
                isPrimary: true,
                userId: "112"),
            sender: UserEntity(
              email: "lidya@gmail.com",
              gender: "female",
              id: "1005",
              phone: "0914281719",
              role: Role.user,
              avatar:
                  "https://cdni.iconscout.com/illustration/premium/thumb/young-girl-8187687-6590629.png?f=webp",
              firstName: "Lidya",
              lastName: "Abebe",
              address: AddressEntity(
                "22 Mazorya",
                city: "AddisAbaba",
                country: "Ethiopia",
                stateProvince: "AA",
                streetAddress: "Bole",
              ),
            ),
            updatedAt: DateTime.now(),
            deletedAt: DateTime.now(),
            receiverBankCardId: "1234",
            rejectedReason: "",
            senderBankCardId: "12344",
            status: LoanContractRequestStatus.pending,
            videoConfirmation:
                "https://media.istockphoto.com/id/1212501173/video/confident-businessman-business-coach-speak-look-at-camera-in-office.mp4?s=mp4-640x640-is&k=20&c=NWApS_7qsVoU_uXPtIErYdd4s3HR_YMzRxCasphAWQI="),
        LoanRequestModel(
            createdAt: DateTime.now(),
            description: "loan request",
            id: "3003",
            interestRate: 44,
            idCardBackPhoto:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkZUUzPWexwYFKYLr3eR81HIW6UGWZcAKoSQ&s',
            idCardFrontPhoto:
                'https://m.media-amazon.com/images/I/81kGjrseg6L._AC_UF1000,1000_QL80_.jpg',
            loanReason: "Purchase",
            loanAmount: 60000,
            loanReasonType: LoanReasonTypes.business,
            loanTenureMonths: 5,
            overdueInterestRate: 14,
            portaitPhoto:
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkZUUzPWexwYFKYLr3eR81HIW6UGWZcAKoSQ&s",
            receiver: UserEntity(
                email: "lidya@gmail.com",
                gender: "female",
                id: "1005",
                phone: "0914281719",
                role: Role.user,
                avatar:
                    "https://cdni.iconscout.com/illustration/premium/thumb/young-girl-8187687-6590629.png?f=webp",
                firstName: "Lidya",
                lastName: "Abebe",
                address: AddressEntity(
                  "22 Mazorya",
                  city: "AddisAbaba",
                  country: "Ethiopia",
                  stateProvince: "AA",
                  streetAddress: "Bole",
                )),
            receiverBankCard: BankCardEntity(
                bank: BankEntity(
                  name: "Abissinia",
                  shortName: "AIB",
                  bin: "thisbin",
                  code: "1234",
                  id: "2001",
                  logo:
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQelz9TbWV_irdMk7ncyxyT5V451aYpt7Xy6Q&s",
                ),
                bankId: "001",
                branch: "Bole",
                cardNumber: "1001",
                createdAt: DateTime.now(),
                deletedAt: DateTime.now(),
                id: "001",
                isPrimary: true,
                userId: "112"),
            senderBankCard: BankCardEntity(
                bank: BankEntity(
                  name: "Abissinia",
                  shortName: "AIB",
                  bin: "thisbin",
                  code: "1234",
                  id: "2001",
                  logo:
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQelz9TbWV_irdMk7ncyxyT5V451aYpt7Xy6Q&s",
                ),
                bankId: "001",
                branch: "Bole",
                cardNumber: "1001",
                createdAt: DateTime.now(),
                deletedAt: DateTime.now(),
                id: "001",
                isPrimary: true,
                userId: "112"),
            sender: UserEntity(
              email: "lidya@gmail.com",
              gender: "female",
              id: "1005",
              phone: "0914281719",
              role: Role.user,
              avatar:
                  "https://cdni.iconscout.com/illustration/premium/thumb/young-girl-8187687-6590629.png?f=webp",
              firstName: "Lidya",
              lastName: "Abebe",
              address: AddressEntity(
                "22 Mazorya",
                city: "AddisAbaba",
                country: "Ethiopia",
                stateProvince: "AA",
                streetAddress: "Bole",
              ),
            ),
            updatedAt: DateTime.now(),
            deletedAt: DateTime.now(),
            receiverBankCardId: "1234",
            rejectedReason: "",
            senderBankCardId: "12344",
            status: LoanContractRequestStatus.pending,
            videoConfirmation:
                "https://media.istockphoto.com/id/1212501173/video/confident-businessman-business-coach-speak-look-at-camera-in-office.mp4?s=mp4-640x640-is&k=20&c=NWApS_7qsVoU_uXPtIErYdd4s3HR_YMzRxCasphAWQI="),
        LoanRequestModel(
            createdAt: DateTime.now(),
            description: "loan request",
            id: "3003",
            interestRate: 44,
            idCardBackPhoto:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkZUUzPWexwYFKYLr3eR81HIW6UGWZcAKoSQ&s',
            idCardFrontPhoto:
                'https://m.media-amazon.com/images/I/81kGjrseg6L._AC_UF1000,1000_QL80_.jpg',
            loanReason: "Purchase",
            loanAmount: 60000,
            loanReasonType: LoanReasonTypes.business,
            loanTenureMonths: 5,
            overdueInterestRate: 14,
            portaitPhoto:
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkZUUzPWexwYFKYLr3eR81HIW6UGWZcAKoSQ&s",
            receiver: UserEntity(
                email: "lidya@gmail.com",
                gender: "female",
                id: "1005",
                phone: "0914281719",
                role: Role.user,
                avatar:
                    "https://cdni.iconscout.com/illustration/premium/thumb/young-girl-8187687-6590629.png?f=webp",
                firstName: "Lidya",
                lastName: "Abebe",
                address: AddressEntity(
                  "22 Mazorya",
                  city: "AddisAbaba",
                  country: "Ethiopia",
                  stateProvince: "AA",
                  streetAddress: "Bole",
                )),
            receiverBankCard: BankCardEntity(
                bank: BankEntity(
                  name: "Abissinia",
                  shortName: "AIB",
                  bin: "thisbin",
                  code: "1234",
                  id: "2001",
                  logo:
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQelz9TbWV_irdMk7ncyxyT5V451aYpt7Xy6Q&s",
                ),
                bankId: "001",
                branch: "Bole",
                cardNumber: "1001",
                createdAt: DateTime.now(),
                deletedAt: DateTime.now(),
                id: "001",
                isPrimary: true,
                userId: "112"),
            senderBankCard: BankCardEntity(
                bank: BankEntity(
                  name: "Abissinia",
                  shortName: "AIB",
                  bin: "thisbin",
                  code: "1234",
                  id: "2001",
                  logo:
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQelz9TbWV_irdMk7ncyxyT5V451aYpt7Xy6Q&s",
                ),
                bankId: "001",
                branch: "Bole",
                cardNumber: "1001",
                createdAt: DateTime.now(),
                deletedAt: DateTime.now(),
                id: "001",
                isPrimary: true,
                userId: "112"),
            sender: UserEntity(
              email: "lidya@gmail.com",
              gender: "female",
              id: "1005",
              phone: "0914281719",
              role: Role.user,
              avatar:
                  "https://cdni.iconscout.com/illustration/premium/thumb/young-girl-8187687-6590629.png?f=webp",
              firstName: "Lidya",
              lastName: "Abebe",
              address: AddressEntity(
                "22 Mazorya",
                city: "AddisAbaba",
                country: "Ethiopia",
                stateProvince: "AA",
                streetAddress: "Bole",
              ),
            ),
            updatedAt: DateTime.now(),
            deletedAt: DateTime.now(),
            receiverBankCardId: "1234",
            rejectedReason: "",
            senderBankCardId: "12344",
            status: LoanContractRequestStatus.pending,
            videoConfirmation:
                "https://media.istockphoto.com/id/1212501173/video/confident-businessman-business-coach-speak-look-at-camera-in-office.mp4?s=mp4-640x640-is&k=20&c=NWApS_7qsVoU_uXPtIErYdd4s3HR_YMzRxCasphAWQI=")
      ];

      final value = Pair(numOfPages, posts);

      return HttpResponse(value, response);
    } on ApiException {
      rethrow;
    } catch (error) {
      error.printError();
      throw ApiException(message: error.toString(), statusCode: 505);
    }
  }

  Future<HttpResponse<Pair<int, List<ContractModel>>>> getContracts(
      String url, Dio client) async {
    try {
      // get access token
      AuthenLocalDataSrc localDataSrc = sl<AuthenLocalDataSrc>();
      String? accessToken = localDataSrc.getAccessToken();
      if (accessToken == null) {
        throw const ApiException(
            message: 'Access token is null', statusCode: 505);
      }

      final response = await client.get(
        url,
        options: Options(
            sendTimeout: const Duration(seconds: 10),
            headers: {'Authorization': 'Bearer $accessToken'}),
      );
      print(url);
      //print('${response.statusCode} : ${response.data["message"].toString()}');
      if (response.statusCode != 200) {
        //print('${response.statusCode} : ${response.data["result"].toString()}');
        throw ApiException(
          message: response.data,
          statusCode: response.statusCode!,
        );
      }

      final int numOfPages = response.data["num_of_pages"];

      final List<DataMap> taskDataList =
          List<DataMap>.from(response.data["result"]);

      List<ContractModel> posts = [];
      for (var element in taskDataList) {
        posts.add(ContractModel.fromJson(element));
      }

      posts = [
        ContractModel(
            amount: 10000,
            borrower: UserEntity(
              email: "lidya@gmail.com",
              gender: "female",
              id: "1005",
              phone: "0914281719",
              role: Role.user,
              avatar:
                  "https://cdni.iconscout.com/illustration/premium/thumb/young-girl-8187687-6590629.png?f=webp",
              firstName: "Lidya",
              lastName: "Abebe",
              address: AddressEntity(
                "22 Mazorya",
                city: "AddisAbaba",
                country: "Ethiopia",
                stateProvince: "AA",
                streetAddress: "Bole",
              ),
            ),
            borrowerBankCard: BankCardEntity(
                bank: BankEntity(
                  name: "Abissinia",
                  shortName: "AIB",
                  bin: "thisbin",
                  code: "1234",
                  id: "2001",
                  logo:
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQelz9TbWV_irdMk7ncyxyT5V451aYpt7Xy6Q&s",
                ),
                bankId: "001",
                branch: "Bole",
                cardNumber: "1001",
                createdAt: DateTime.now(),
                deletedAt: DateTime.now(),
                id: "001",
                isPrimary: true,
                userId: "112"),
            borrowerBankCardId: '1000123414',
            contractTemplateId: '1111',
            createdAt: DateTime.now(),
            expiredAt: DateTime.now(),
            id: 'asdfadsf',
            interestRate: 3.5,
            lender: UserEntity(
              email: "lidya@gmail.com",
              gender: "female",
              id: "1005",
              phone: "0914281719",
              role: Role.user,
              avatar:
                  "https://cdni.iconscout.com/illustration/premium/thumb/young-girl-8187687-6590629.png?f=webp",
              firstName: "Lidya",
              lastName: "Abebe",
              address: AddressEntity(
                "22 Mazorya",
                city: "AddisAbaba",
                country: "Ethiopia",
                stateProvince: "AA",
                streetAddress: "Bole",
              ),
            ),
            lenderBankCard: BankCardEntity(
                bank: BankEntity(
                  name: "Abissinia",
                  shortName: "AIB",
                  bin: "thisbin",
                  code: "1234",
                  id: "2001",
                  logo:
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQelz9TbWV_irdMk7ncyxyT5V451aYpt7Xy6Q&s",
                ),
                bankId: "001",
                branch: "Bole",
                cardNumber: "1001",
                createdAt: DateTime.now(),
                deletedAt: DateTime.now(),
                id: "001",
                isPrimary: true,
                userId: "112"),
            lenderBankCardId: '10000123444',
            loanContractRequestId: '1lkjfdsljf',
            loanReason: 'for business',
            loanReasonType: LoanReasonTypes.business,
            overdueInterestRate: 1.2,
            tenureInMonths: 3),
        ContractModel(
            amount: 9000,
            borrower: UserEntity(
              email: "lidya@gmail.com",
              gender: "female",
              id: "1005",
              phone: "0914281719",
              role: Role.user,
              avatar:
                  "https://cdni.iconscout.com/illustration/premium/thumb/young-girl-8187687-6590629.png?f=webp",
              firstName: "Lidya",
              lastName: "Abebe",
              address: AddressEntity(
                "22 Mazorya",
                city: "AddisAbaba",
                country: "Ethiopia",
                stateProvince: "AA",
                streetAddress: "Bole",
              ),
            ),
            borrowerBankCard: BankCardEntity(
                bank: BankEntity(
                  name: "Abissinia",
                  shortName: "AIB",
                  bin: "thisbin",
                  code: "1234",
                  id: "2001",
                  logo:
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQelz9TbWV_irdMk7ncyxyT5V451aYpt7Xy6Q&s",
                ),
                bankId: "001",
                branch: "Bole",
                cardNumber: "1001",
                createdAt: DateTime.now(),
                deletedAt: DateTime.now(),
                id: "001",
                isPrimary: true,
                userId: "112"),
            borrowerBankCardId: '1000123414',
            contractTemplateId: '1111',
            createdAt: DateTime.now(),
            expiredAt: DateTime.now(),
            id: 'asdfadsf',
            interestRate: 3.5,
            lender: UserEntity(
              email: "lidya@gmail.com",
              gender: "female",
              id: "1005",
              phone: "0914281719",
              role: Role.user,
              avatar:
                  "https://cdni.iconscout.com/illustration/premium/thumb/young-girl-8187687-6590629.png?f=webp",
              firstName: "Lidya",
              lastName: "Abebe",
              address: AddressEntity(
                "22 Mazorya",
                city: "AddisAbaba",
                country: "Ethiopia",
                stateProvince: "AA",
                streetAddress: "Bole",
              ),
            ),
            lenderBankCard: BankCardEntity(
                bank: BankEntity(
                  name: "Abissinia",
                  shortName: "AIB",
                  bin: "thisbin",
                  code: "1234",
                  id: "2001",
                  logo:
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQelz9TbWV_irdMk7ncyxyT5V451aYpt7Xy6Q&s",
                ),
                bankId: "001",
                branch: "Bole",
                cardNumber: "1001",
                createdAt: DateTime.now(),
                deletedAt: DateTime.now(),
                id: "001",
                isPrimary: true,
                userId: "112"),
            lenderBankCardId: '10000123444',
            loanContractRequestId: '1lkjfdsljf',
            loanReason: 'for business',
            loanReasonType: LoanReasonTypes.business,
            overdueInterestRate: 1.2,
            tenureInMonths: 3),
        ContractModel(
            amount: 11000,
            borrower: UserEntity(
              email: "lidya@gmail.com",
              gender: "female",
              id: "1005",
              phone: "0914281719",
              role: Role.user,
              avatar:
                  "https://cdni.iconscout.com/illustration/premium/thumb/young-girl-8187687-6590629.png?f=webp",
              firstName: "Lidya",
              lastName: "Abebe",
              address: AddressEntity(
                "22 Mazorya",
                city: "AddisAbaba",
                country: "Ethiopia",
                stateProvince: "AA",
                streetAddress: "Bole",
              ),
            ),
            borrowerBankCard: BankCardEntity(
                bank: BankEntity(
                  name: "Abissinia",
                  shortName: "AIB",
                  bin: "thisbin",
                  code: "1234",
                  id: "2001",
                  logo:
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQelz9TbWV_irdMk7ncyxyT5V451aYpt7Xy6Q&s",
                ),
                bankId: "001",
                branch: "Bole",
                cardNumber: "1001",
                createdAt: DateTime.now(),
                deletedAt: DateTime.now(),
                id: "001",
                isPrimary: true,
                userId: "112"),
            borrowerBankCardId: '1000123414',
            contractTemplateId: '1111',
            createdAt: DateTime.now(),
            expiredAt: DateTime.now(),
            id: 'asdfadsf',
            interestRate: 3.5,
            lender: UserEntity(
              email: "lidya@gmail.com",
              gender: "female",
              id: "1005",
              phone: "0914281719",
              role: Role.user,
              avatar:
                  "https://cdni.iconscout.com/illustration/premium/thumb/young-girl-8187687-6590629.png?f=webp",
              firstName: "Lidya",
              lastName: "Abebe",
              address: AddressEntity(
                "22 Mazorya",
                city: "AddisAbaba",
                country: "Ethiopia",
                stateProvince: "AA",
                streetAddress: "Bole",
              ),
            ),
            lenderBankCard: BankCardEntity(
                bank: BankEntity(
                  name: "Abissinia",
                  shortName: "AIB",
                  bin: "thisbin",
                  code: "1234",
                  id: "2001",
                  logo:
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQelz9TbWV_irdMk7ncyxyT5V451aYpt7Xy6Q&s",
                ),
                bankId: "001",
                branch: "Bole",
                cardNumber: "1001",
                createdAt: DateTime.now(),
                deletedAt: DateTime.now(),
                id: "001",
                isPrimary: true,
                userId: "112"),
            lenderBankCardId: '10000123444',
            loanContractRequestId: '1lkjfdsljf',
            loanReason: 'for business',
            loanReasonType: LoanReasonTypes.business,
            overdueInterestRate: 1.2,
            tenureInMonths: 3),
        ContractModel(
            amount: 12000,
            borrower: UserEntity(
              email: "lidya@gmail.com",
              gender: "female",
              id: "1005",
              phone: "0914281719",
              role: Role.user,
              avatar:
                  "https://cdni.iconscout.com/illustration/premium/thumb/young-girl-8187687-6590629.png?f=webp",
              firstName: "Lidya",
              lastName: "Abebe",
              address: AddressEntity(
                "22 Mazorya",
                city: "AddisAbaba",
                country: "Ethiopia",
                stateProvince: "AA",
                streetAddress: "Bole",
              ),
            ),
            borrowerBankCard: BankCardEntity(
                bank: BankEntity(
                  name: "Abissinia",
                  shortName: "AIB",
                  bin: "thisbin",
                  code: "1234",
                  id: "2001",
                  logo:
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQelz9TbWV_irdMk7ncyxyT5V451aYpt7Xy6Q&s",
                ),
                bankId: "001",
                branch: "Bole",
                cardNumber: "1001",
                createdAt: DateTime.now(),
                deletedAt: DateTime.now(),
                id: "001",
                isPrimary: true,
                userId: "112"),
            borrowerBankCardId: '1000123414',
            contractTemplateId: '1111',
            createdAt: DateTime.now(),
            expiredAt: DateTime.now(),
            id: 'asdfadsf',
            interestRate: 3.5,
            lender: UserEntity(
              email: "lidya@gmail.com",
              gender: "female",
              id: "1005",
              phone: "0914281719",
              role: Role.user,
              avatar:
                  "https://cdni.iconscout.com/illustration/premium/thumb/young-girl-8187687-6590629.png?f=webp",
              firstName: "Lidya",
              lastName: "Abebe",
              address: AddressEntity(
                "22 Mazorya",
                city: "AddisAbaba",
                country: "Ethiopia",
                stateProvince: "AA",
                streetAddress: "Bole",
              ),
            ),
            lenderBankCard: BankCardEntity(
                bank: BankEntity(
                  name: "Abissinia",
                  shortName: "AIB",
                  bin: "thisbin",
                  code: "1234",
                  id: "2001",
                  logo:
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQelz9TbWV_irdMk7ncyxyT5V451aYpt7Xy6Q&s",
                ),
                bankId: "001",
                branch: "Bole",
                cardNumber: "1001",
                createdAt: DateTime.now(),
                deletedAt: DateTime.now(),
                id: "001",
                isPrimary: true,
                userId: "112"),
            lenderBankCardId: '10000123444',
            loanContractRequestId: '1lkjfdsljf',
            loanReason: 'for business',
            loanReasonType: LoanReasonTypes.business,
            overdueInterestRate: 1.2,
            tenureInMonths: 3)
      ];
      final value = Pair(numOfPages, posts);

      return HttpResponse(value, response);
    } on ApiException {
      rethrow;
    } catch (error) {
      error.printError();
      throw ApiException(message: error.toString(), statusCode: 505);
    }
  }
}
